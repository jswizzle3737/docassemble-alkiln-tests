# PDF Field Extractor for Docassemble

## Overview

This tool uses PyMuPDF to automatically extract form fields from PDF documents and generate docassemble interview YAML files. It's designed to speed up the process of creating docassemble interviews from existing PDF forms.

## Features

- ✅ Extract form fields from any fillable PDF
- ✅ Identify field types (text, checkbox, radiobutton, etc.)
- ✅ Generate docassemble YAML template files
- ✅ Batch process multiple PDFs
- ✅ Support for PyMuPDF Pro features (optional)

## Installation

The PDF extractor requires PyMuPDF:

```bash
pip install pymupdf
```

Or install the entire package:

```bash
cd /path/to/docassemble-alkiln-tests
pip install -e .
```

## Usage

### Single PDF Extraction

Extract fields from one PDF file:

```bash
# Basic usage (auto-generates output filename)
python -m docassemble.alkilntests.pdf_extractor input.pdf

# Specify output file
python -m docassemble.alkilntests.pdf_extractor input.pdf output.yml

# Example with project files
python -m docassemble.alkilntests.pdf_extractor \
    docassemble/alkilntests/data/static/A1.pdf \
    docassemble/alkilntests/data/sources/A1.yml
```

### Batch Processing

Process all PDFs in a directory:

```bash
# Basic usage (uses default directories)
python batch_extract_pdfs.py

# Specify input and output directories
python batch_extract_pdfs.py static/ sources/

# Full path example
python batch_extract_pdfs.py \
    docassemble/alkilntests/data/static \
    docassemble/alkilntests/data/sources

# Overwrite existing YAML files
python batch_extract_pdfs.py static/ sources/ --overwrite
```

## Output Format

The tool generates a docassemble YAML file with:

1. **Metadata section**: Title, description, authors
2. **PDF template mapping**: Links PDF fields to variables
3. **Question blocks placeholder**: Where you add interview questions

Example output:

```yaml
---
metadata:
  title: "Interview for Form"
  description: An interactive web form to fill out the form.pdf document.
---
template: form.pdf
fields:
  - "applicant_name": applicant_name
  - "applicant_address": applicant_address
  - "signature_date": signature_date
---
# Question blocks go here
```

## PyMuPDF Pro Features

The tool supports PyMuPDF Pro features for enhanced PDF processing. If you have a license key:

```bash
# Set environment variable
export PYMUPDF_LICENSE_KEY="your-key-here"

# Or unlock in code (see pdf_extractor.py)
```

Without a Pro license, the tool works with standard PyMuPDF features.

## Python API

Use the extractor programmatically:

```python
from docassemble.alkilntests.pdf_extractor import PDFFieldExtractor

# Context manager usage (recommended)
with PDFFieldExtractor("input.pdf") as extractor:
    # Extract fields
    fields = extractor.extract_fields()
    
    # Print field information
    for field in fields:
        print(f"{field['name']}: {field['type']}")
    
    # Generate YAML
    extractor.generate_yaml("output.yml")

# Manual usage
extractor = PDFFieldExtractor("input.pdf")
extractor.open_pdf()
extractor.extract_fields()
extractor.generate_yaml("output.yml")
extractor.close()
```

## Field Types

The extractor identifies these PDF form field types:

- **text**: Text input fields
- **checkbox**: Checkboxes
- **radiobutton**: Radio buttons
- **combobox**: Dropdown menus
- **listbox**: List boxes
- **button**: Buttons
- **signature**: Signature fields

## Next Steps

After generating a YAML file:

1. **Upload PDF to docassemble**: Go to Playground → Templates → Upload your PDF
2. **Edit YAML file**: Add question blocks to collect user input
3. **Map variables**: Ensure variable names match between questions and template
4. **Test**: Run the interview in the playground
5. **Refine**: Adjust field mappings as needed

## Example Workflow

```bash
# 1. Extract fields from a PDF
python -m docassemble.alkilntests.pdf_extractor \
    docassemble/alkilntests/data/static/MyForm.pdf \
    docassemble/alkilntests/data/questions/my_interview.yml

# 2. Edit the generated YAML file to add questions
# (Add question blocks between the template section and end)

# 3. Upload MyForm.pdf to docassemble Templates folder

# 4. Test the interview in docassemble playground
```

## Troubleshooting

### "No fields found"
- The PDF may not be a fillable form
- Try opening the PDF in Adobe Acrobat to verify it has form fields

### "Error opening PDF"
- Check that the file path is correct
- Ensure the PDF is not corrupted
- Verify PyMuPDF is installed: `pip list | grep pymupdf`

### Field names are complex
- PDF field names come from the PDF itself (e.g., `form1[0].#subform[1].fieldName[0]`)
- You can rename them in the YAML file, but keep the original names in the `template:` section

### "PyMuPDF is not installed"
```bash
pip install pymupdf
# or
pip install -e .
```

## Advanced Usage

### Custom field processing

```python
from docassemble.alkilntests.pdf_extractor import PDFFieldExtractor

with PDFFieldExtractor("form.pdf") as extractor:
    fields = extractor.extract_fields()
    
    # Filter only text fields
    text_fields = [f for f in fields if f['type'] == 'text']
    
    # Custom YAML generation
    yaml_content = extractor.generate_yaml()
    
    # Modify and save
    with open("custom.yml", "w") as f:
        f.write(yaml_content)
```

### Processing PDFs with complex structures

For PDFs with many pages or complex field hierarchies, the extractor:
- Automatically deduplicates field names across pages
- Preserves the original PDF field naming structure
- Tracks which page each field first appears on

## Resources

- [PyMuPDF Documentation](https://pymupdf.readthedocs.io/)
- [Docassemble PDF Templates](https://docassemble.org/docs/documents.html#pdf%20template%20file)
- [Assembly Line Project](https://suffolklitlab.org/docassemble-AssemblyLine-documentation/)

## Support

For issues or questions:
- Check the troubleshooting section above
- Review the [main README](../README.md)
- Open an issue on GitHub
