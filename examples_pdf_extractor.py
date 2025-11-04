#!/usr/bin/env python3
"""
Example: Using the PDF Field Extractor API

This script demonstrates how to use the PDFFieldExtractor class programmatically.
"""

import sys
from pathlib import Path

# Add project to path
sys.path.insert(0, str(Path(__file__).parent))

from docassemble.alkilntests.pdf_extractor import PDFFieldExtractor


def example_basic_usage():
    """Example 1: Basic usage with context manager."""
    print("=" * 70)
    print("Example 1: Basic Usage")
    print("=" * 70)
    
    pdf_path = "docassemble/alkilntests/data/static/N1.pdf"
    
    with PDFFieldExtractor(pdf_path) as extractor:
        # Extract fields
        fields = extractor.extract_fields()
        
        # Print summary
        print(f"\nFound {len(fields)} fields in {extractor.pdf_name}")
        print("\nFirst 5 fields:")
        for field in fields[:5]:
            print(f"  - {field['name']} ({field['type']})")
        
        # Generate YAML
        yaml_content = extractor.generate_yaml()
        print(f"\nGenerated YAML preview (first 500 chars):")
        print(yaml_content[:500] + "...")


def example_filter_fields():
    """Example 2: Filter and analyze specific field types."""
    print("\n" + "=" * 70)
    print("Example 2: Filtering Fields by Type")
    print("=" * 70)
    
    pdf_path = "docassemble/alkilntests/data/static/N1.pdf"
    
    with PDFFieldExtractor(pdf_path) as extractor:
        fields = extractor.extract_fields()
        
        # Count field types
        field_types = {}
        for field in fields:
            field_type = field['type']
            field_types[field_type] = field_types.get(field_type, 0) + 1
        
        print("\nField Type Summary:")
        for field_type, count in sorted(field_types.items()):
            print(f"  {field_type:15s}: {count:3d} fields")
        
        # Show all checkboxes
        checkboxes = [f for f in fields if f['type'] == 'checkbox']
        if checkboxes:
            print(f"\nCheckbox fields ({len(checkboxes)}):")
            for field in checkboxes:
                print(f"  - {field['name']}")


def example_manual_mode():
    """Example 3: Manual mode without context manager."""
    print("\n" + "=" * 70)
    print("Example 3: Manual Mode")
    print("=" * 70)
    
    pdf_path = "docassemble/alkilntests/data/static/Affidavit.pdf"
    
    # Create extractor
    extractor = PDFFieldExtractor(pdf_path)
    
    try:
        # Open PDF
        if not extractor.open_pdf():
            print("Failed to open PDF")
            return
        
        # Extract fields
        fields = extractor.extract_fields()
        
        print(f"\nExtracted {len(fields)} fields:")
        for i, field in enumerate(fields, 1):
            print(f"  {i}. {field['name']}")
        
        # Generate YAML to file
        output_path = "/tmp/example_output.yml"
        extractor.generate_yaml(output_path)
        print(f"\n✓ Saved to: {output_path}")
        
    finally:
        # Always close
        extractor.close()


def example_batch_info():
    """Example 4: Get info about multiple PDFs without generating YAML."""
    print("\n" + "=" * 70)
    print("Example 4: Batch Information Gathering")
    print("=" * 70)
    
    pdf_dir = Path("docassemble/alkilntests/data/static")
    pdf_files = sorted(pdf_dir.glob("*.pdf"))[:5]  # First 5 PDFs
    
    print(f"\nAnalyzing {len(pdf_files)} PDFs...\n")
    
    results = []
    for pdf_path in pdf_files:
        try:
            with PDFFieldExtractor(str(pdf_path)) as extractor:
                fields = extractor.extract_fields()
                results.append({
                    'name': pdf_path.name,
                    'pages': len(extractor.doc),
                    'fields': len(fields)
                })
        except Exception as e:
            print(f"Error processing {pdf_path.name}: {e}")
    
    # Print table
    print(f"{'PDF Name':<40} {'Pages':<8} {'Fields':<8}")
    print("-" * 70)
    for result in results:
        print(f"{result['name']:<40} {result['pages']:<8} {result['fields']:<8}")


def main():
    """Run all examples."""
    print("\n" + "=" * 70)
    print("PDF Field Extractor - API Examples")
    print("=" * 70)
    
    try:
        example_basic_usage()
        example_filter_fields()
        example_manual_mode()
        example_batch_info()
        
        print("\n" + "=" * 70)
        print("✓ All examples completed successfully!")
        print("=" * 70)
        
    except Exception as e:
        print(f"\n✗ Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
