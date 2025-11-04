"""
PDF Field Extractor for Docassemble Interviews

This module uses PyMuPDF to extract form fields from PDF documents
and generate docassemble interview YAML files. PyMuPDF Pro features
are optional and will be used if available.

Usage:
    python -m docassemble.alkilntests.pdf_extractor input.pdf output.yml
"""

import os
import sys
from datetime import datetime
from typing import Any, Dict, List, Optional

try:
    import pymupdf
except ImportError:
    print("Error: PyMuPDF is not installed.")
    print("Install it with: pip install pymupdf")
    sys.exit(1)

# Try to import Pro features (optional)
try:
    import pymupdf.pro
    HAS_PRO = True
except ImportError:
    HAS_PRO = False


class PDFFieldExtractor:
    """Extract form fields from PDF documents using PyMuPDF.
    
    PyMuPDF Pro features are optional and will be used if available.
    """

    def __init__(self, pdf_path: str):
        """
        Initialize the extractor with a PDF file.

        Args:
            pdf_path: Path to the PDF file
        """
        self.pdf_path = pdf_path
        self.pdf_name = os.path.basename(pdf_path)
        self.doc = None
        self.fields = []

    def unlock_pro(self, license_key: Optional[str] = None):
        """
        Unlock PyMuPDF Pro features (if available).

        Args:
            license_key: Optional license key. If not provided, will run in trial mode.

        Returns:
            True if Pro features are available and unlocked, False otherwise
        """
        if not HAS_PRO:
            print("ℹ PyMuPDF Pro not available (using standard version)")
            return False

        if license_key:
            try:
                pymupdf.pro.unlock(license_key)
                if pymupdf.pro.is_unlocked:
                    print(f"✓ PyMuPDF Pro unlocked successfully")
                    return True
            except Exception as e:
                print(f"Warning: Could not unlock Pro features: {e}")
                return False
        return False

    def open_pdf(self):
        """Open the PDF document."""
        try:
            self.doc = pymupdf.open(self.pdf_path)
            print(f"✓ Opened PDF: {self.pdf_name} ({len(self.doc)} pages)")
            return True
        except Exception as e:
            print(f"✗ Error opening PDF: {e}")
            return False

    def extract_fields(self) -> List[Dict[str, Any]]:
        """
        Extract form fields from the PDF.

        Returns:
            List of field dictionaries with name, type, and value information
        """
        if not self.doc:
            print("Error: PDF not opened. Call open_pdf() first.")
            return []

        self.fields = []
        field_names = set()

        for page_num in range(len(self.doc)):
            page = self.doc[page_num]

            # Get form widgets on this page
            widgets = page.widgets()

            for widget in widgets:
                field_name = widget.field_name
                field_type = widget.field_type
                field_value = widget.field_value

                # Skip if we've already seen this field
                if field_name in field_names:
                    continue

                field_names.add(field_name)

                field_info = {
                    "name": field_name,
                    "type": self._get_field_type_name(field_type),
                    "value": field_value,
                    "page": page_num + 1,
                }

                self.fields.append(field_info)

        print(f"✓ Extracted {len(self.fields)} unique form fields")
        return self.fields

    def _get_field_type_name(self, field_type: int) -> str:
        """
        Convert PyMuPDF field type constant to readable name.

        Args:
            field_type: PyMuPDF field type constant

        Returns:
            Human-readable field type name
        """
        field_types = {
            pymupdf.PDF_WIDGET_TYPE_BUTTON: "button",
            pymupdf.PDF_WIDGET_TYPE_CHECKBOX: "checkbox",
            pymupdf.PDF_WIDGET_TYPE_COMBOBOX: "combobox",
            pymupdf.PDF_WIDGET_TYPE_LISTBOX: "listbox",
            pymupdf.PDF_WIDGET_TYPE_RADIOBUTTON: "radiobutton",
            pymupdf.PDF_WIDGET_TYPE_SIGNATURE: "signature",
            pymupdf.PDF_WIDGET_TYPE_TEXT: "text",
        }
        return field_types.get(field_type, "unknown")

    def generate_yaml(self, output_path: Optional[str] = None) -> str:
        """
        Generate a docassemble interview YAML file from extracted fields.

        Args:
            output_path: Path to save the YAML file. If None, returns YAML as string.

        Returns:
            Generated YAML content
        """
        if not self.fields:
            print("Warning: No fields extracted. Extracting now...")
            self.extract_fields()

        yaml_content = self._build_yaml_content()

        if output_path:
            try:
                with open(output_path, "w", encoding="utf-8") as f:
                    f.write(yaml_content)
                print(f"✓ Generated YAML file: {output_path}")
            except Exception as e:
                print(f"✗ Error writing YAML file: {e}")

        return yaml_content

    def _build_yaml_content(self) -> str:
        """Build the YAML content from extracted fields."""
        today = datetime.now().strftime("%Y-%m-%d")
        pdf_name_no_ext = os.path.splitext(self.pdf_name)[0]

        # Build the header
        yaml_lines = [
            "---",
            "# " + "=" * 84,
            "#  Docassemble Interview YAML File",
            "#  Generated automatically by the PDF Question Extractor",
            "#",
            f"#  PDF Source: {self.pdf_name}",
            f"#  Generated on: {today}",
            "#",
            "#  This file is a starting point. You will likely need to adjust the field",
            '#  placements in the Docassemble playground\'s "Template" editor.',
            "# " + "=" * 84,
            "",
            "metadata:",
            f'  title: "Interview for {pdf_name_no_ext}"',
            f"  description: An interactive web form to fill out the {self.pdf_name} document.",
            "  authors:",
            "    - name: PDF Question Extractor AI",
            "---",
            "# This block links your interview questions (variables) to the fillable fields",
            f"# in your PDF template. You must upload {self.pdf_name} to your 'Templates' folder.",
            "#",
            "# For more info: https://docassemble.org/docs/pdfform.html#pdftemplate",
            f"template: {self.pdf_name}",
            "fields:",
        ]

        # Add field mappings
        for field in self.fields:
            field_name = field["name"]
            yaml_lines.append(f'  - "{field_name}": {field_name}')

        yaml_lines.extend(
            [
                "---",
                "# Question blocks go here",
                "# Example:",
                "# question: What is your name?",
                "# fields:",
                f"#   - First Name: {self.fields[0]['name'] if self.fields else 'fieldName'}",
                "---",
            ]
        )

        return "\n".join(yaml_lines)

    def close(self):
        """Close the PDF document."""
        if self.doc:
            self.doc.close()
            print(f"✓ Closed PDF: {self.pdf_name}")

    def __enter__(self):
        """Context manager entry."""
        self.open_pdf()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit."""
        self.close()


def main():
    """Command-line interface for PDF field extraction."""
    if len(sys.argv) < 2:
        print("Usage: python -m docassemble.alkilntests.pdf_extractor <pdf_file> [output.yml]")
        print("\nExamples:")
        print("  python -m docassemble.alkilntests.pdf_extractor input.pdf")
        print("  python -m docassemble.alkilntests.pdf_extractor input.pdf output.yml")
        sys.exit(1)

    pdf_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else None

    if not os.path.exists(pdf_path):
        print(f"Error: PDF file not found: {pdf_path}")
        sys.exit(1)

    # Auto-generate output path if not provided
    if not output_path:
        base_name = os.path.splitext(os.path.basename(pdf_path))[0]
        output_path = f"{base_name}.yml"

    # Check if PyMuPDF Pro is available
    print("PyMuPDF Field Extractor")
    print("-" * 50)

    # Try to unlock Pro features (will use trial if no key provided)
    license_key = os.environ.get("PYMUPDF_LICENSE_KEY")
    if license_key:
        print("Found license key in environment")

    # Extract fields
    with PDFFieldExtractor(pdf_path) as extractor:
        if license_key:
            extractor.unlock_pro(license_key)

        extractor.extract_fields()

        # Display extracted fields
        if extractor.fields:
            print("\nExtracted Fields:")
            print("-" * 50)
            for i, field in enumerate(extractor.fields, 1):
                print(f"{i:3d}. {field['name']:40s} ({field['type']})")

        # Generate YAML
        print("\n" + "-" * 50)
        extractor.generate_yaml(output_path)

    print("\n✓ Done!")


if __name__ == "__main__":
    main()
