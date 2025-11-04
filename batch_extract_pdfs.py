#!/usr/bin/env python3
"""
Batch PDF Field Extractor

Process multiple PDF files and generate docassemble YAML files for each.

Usage:
    python batch_extract_pdfs.py [input_directory] [output_directory]
    
Example:
    python batch_extract_pdfs.py docassemble/alkilntests/data/static docassemble/alkilntests/data/sources
"""

import os
import sys
from pathlib import Path

# Add the project root to Python path
project_root = Path(__file__).parent
sys.path.insert(0, str(project_root))

from docassemble.alkilntests.pdf_extractor import PDFFieldExtractor


def batch_extract(input_dir: str, output_dir: str, overwrite: bool = False):
    """
    Extract fields from all PDFs in input directory and generate YAML files.
    
    Args:
        input_dir: Directory containing PDF files
        output_dir: Directory to save generated YAML files
        overwrite: Whether to overwrite existing YAML files
    """
    # Ensure output directory exists
    os.makedirs(output_dir, exist_ok=True)
    
    # Find all PDF files
    pdf_files = list(Path(input_dir).glob("*.pdf"))
    
    if not pdf_files:
        print(f"No PDF files found in {input_dir}")
        return
    
    print(f"Found {len(pdf_files)} PDF files")
    print("=" * 70)
    
    success_count = 0
    skip_count = 0
    error_count = 0
    
    for pdf_path in sorted(pdf_files):
        pdf_name = pdf_path.stem  # filename without extension
        output_path = Path(output_dir) / f"{pdf_name}.yml"
        
        # Skip if output already exists and overwrite is False
        if output_path.exists() and not overwrite:
            print(f"⊘ Skipping {pdf_name}.pdf (YAML already exists)")
            skip_count += 1
            continue
        
        print(f"\n📄 Processing: {pdf_path.name}")
        print("-" * 70)
        
        try:
            with PDFFieldExtractor(str(pdf_path)) as extractor:
                fields = extractor.extract_fields()
                
                if not fields:
                    print(f"⚠ Warning: No fields found in {pdf_path.name}")
                
                extractor.generate_yaml(str(output_path))
                success_count += 1
                
        except Exception as e:
            print(f"✗ Error processing {pdf_path.name}: {e}")
            error_count += 1
    
    # Summary
    print("\n" + "=" * 70)
    print("SUMMARY")
    print("=" * 70)
    print(f"✓ Successfully processed: {success_count}")
    print(f"⊘ Skipped (already exist): {skip_count}")
    print(f"✗ Errors: {error_count}")
    print(f"Total PDFs: {len(pdf_files)}")


def main():
    """Main entry point for batch processing."""
    if len(sys.argv) < 2:
        print("Batch PDF Field Extractor")
        print("=" * 70)
        print("\nUsage:")
        print("  python batch_extract_pdfs.py <input_dir> [output_dir] [--overwrite]")
        print("\nExamples:")
        print("  python batch_extract_pdfs.py static/")
        print("  python batch_extract_pdfs.py static/ sources/")
        print("  python batch_extract_pdfs.py static/ sources/ --overwrite")
        print("\nDefault:")
        print("  Input:  docassemble/alkilntests/data/static/")
        print("  Output: docassemble/alkilntests/data/sources/")
        sys.exit(0)
    
    # Parse arguments
    input_dir = sys.argv[1] if len(sys.argv) > 1 else "docassemble/alkilntests/data/static"
    output_dir = sys.argv[2] if len(sys.argv) > 2 else "docassemble/alkilntests/data/sources"
    overwrite = "--overwrite" in sys.argv or "-f" in sys.argv
    
    # Validate input directory
    if not os.path.exists(input_dir):
        print(f"Error: Input directory not found: {input_dir}")
        sys.exit(1)
    
    if not os.path.isdir(input_dir):
        print(f"Error: Input path is not a directory: {input_dir}")
        sys.exit(1)
    
    print(f"Input directory:  {input_dir}")
    print(f"Output directory: {output_dir}")
    print(f"Overwrite mode:   {'Yes' if overwrite else 'No'}")
    print()
    
    # Process PDFs
    batch_extract(input_dir, output_dir, overwrite)


if __name__ == "__main__":
    main()
