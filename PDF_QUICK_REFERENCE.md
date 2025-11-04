# PDF Field Extractor - Quick Reference

## Installation
```bash
pip install pymupdf
```

## Command-Line Usage

### Extract Single PDF
```bash
# Auto-generate output filename
python -m docassemble.alkilntests.pdf_extractor input.pdf

# Specify output file
python -m docassemble.alkilntests.pdf_extractor input.pdf output.yml
```

### Batch Process PDFs
```bash
# Use default directories
python batch_extract_pdfs.py

# Specify directories
python batch_extract_pdfs.py input_dir/ output_dir/

# Overwrite existing files
python batch_extract_pdfs.py input_dir/ output_dir/ --overwrite
```

## Python API

### Basic Usage
```python
from docassemble.alkilntests.pdf_extractor import PDFFieldExtractor

with PDFFieldExtractor("form.pdf") as extractor:
    fields = extractor.extract_fields()
    extractor.generate_yaml("form.yml")
```

### Get Field Information
```python
with PDFFieldExtractor("form.pdf") as extractor:
    fields = extractor.extract_fields()
    
    for field in fields:
        print(f"{field['name']}: {field['type']}")
```

### Filter by Field Type
```python
with PDFFieldExtractor("form.pdf") as extractor:
    fields = extractor.extract_fields()
    
    # Get only text fields
    text_fields = [f for f in fields if f['type'] == 'text']
    
    # Get only checkboxes
    checkboxes = [f for f in fields if f['type'] == 'checkbox']
```

### Generate YAML as String
```python
with PDFFieldExtractor("form.pdf") as extractor:
    extractor.extract_fields()
    yaml_content = extractor.generate_yaml()  # No file argument
    print(yaml_content)
```

## Field Types
- `text` - Text input fields
- `checkbox` - Checkboxes
- `radiobutton` - Radio buttons
- `combobox` - Dropdown menus
- `listbox` - List boxes
- `button` - Buttons
- `signature` - Signature fields

## Field Object Structure
```python
{
    'name': 'form1[0].field_name[0]',
    'type': 'text',
    'value': None,
    'page': 1
}
```

## Output Format
Generated YAML includes:
1. Metadata (title, description, authors)
2. PDF template field mappings
3. Placeholder for question blocks

## Common Workflows

### Workflow 1: Quick Extract
```bash
python -m docassemble.alkilntests.pdf_extractor myform.pdf
# Creates myform.yml
```

### Workflow 2: Batch Process All Forms
```bash
python batch_extract_pdfs.py docassemble/alkilntests/data/static/
# Processes all PDFs in directory
```

### Workflow 3: Programmatic Processing
```python
import os
from docassemble.alkilntests.pdf_extractor import PDFFieldExtractor

pdf_files = [f for f in os.listdir('.') if f.endswith('.pdf')]

for pdf_file in pdf_files:
    with PDFFieldExtractor(pdf_file) as extractor:
        fields = extractor.extract_fields()
        print(f"{pdf_file}: {len(fields)} fields")
        extractor.generate_yaml(pdf_file.replace('.pdf', '.yml'))
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "PyMuPDF is not installed" | Run `pip install pymupdf` |
| "No fields found" | PDF may not be fillable |
| "Error opening PDF" | Check file path and PDF integrity |
| Complex field names | Normal - they come from the PDF structure |

## Next Steps After Generation

1. Upload PDF to docassemble Templates folder
2. Edit YAML to add question blocks
3. Map variables between questions and template
4. Test in docassemble playground
5. Refine field mappings as needed

## Resources
- [Full Guide](./PDF_EXTRACTOR_GUIDE.md)
- [Examples](./examples_pdf_extractor.py)
- [PyMuPDF Docs](https://pymupdf.readthedocs.io/)
- [Docassemble PDF Templates](https://docassemble.org/docs/documents.html#pdf%20template%20file)
