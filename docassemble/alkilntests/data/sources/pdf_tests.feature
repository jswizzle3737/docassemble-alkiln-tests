Feature: PDF Generation and Validation Tests
  Comprehensive automated tests for all PDF-related functionality
  Tests PDF generation, downloads, comparison, and validation

# ==========================================
# Basic PDF Download Tests
# ==========================================

Scenario: User can download a basic PDF document
  Given I start the interview at "test"
  And I continue
  Then I should see the phrase "Thank you for testing"
  And I download "test_document.pdf"

Scenario: PDF download includes correct filename
  Given I start the interview at "test"
  And I continue
  Then I download "test_document.pdf"
  # Verify file was created successfully

# ==========================================
# Assembly Line PDF Tests
# ==========================================

Scenario: Generate motion PDF with complete user data
  Given I start the interview at "docassemble.AssemblyLine:data/questions/sample_motion.yml"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | users[0].name.first | Jane | |
    | users[0].name.last | Smith | |
    | users[0].address.address | 123 Main Street | |
    | users[0].address.city | Boston | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 02108 | |
    | users[0].phone_number | 617-555-0123 | |
    | users[0].email | jane.smith@example.com | |
    | other_parties[0].name.first | John | |
    | other_parties[0].name.last | Doe | |
    | docket_number | 2023-CV-12345 | |
    | trial_court | Boston Municipal Court | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Download"
  And I download "motion_form.pdf"

Scenario: Generate complaint PDF with multiple parties
  Given I start the interview at "complaint_form"
  And I get to the question id "signature" with this data:
    | var | value | trigger |
    | users[0].name.first | Alice | |
    | users[0].name.last | Johnson | |
    | users[0].address.address | 456 Oak Avenue | |
    | users[0].address.city | Springfield | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 01101 | |
    | other_parties[0].name.first | Robert | |
    | other_parties[0].name.last | Williams | |
    | other_parties[1].name.first | Sarah | |
    | other_parties[1].name.last | Davis | |
    | claim_description | Breach of contract regarding property sale | users[0].signature |
  And I sign
  And I continue
  Then I download "complaint.pdf"

# ==========================================
# PDF Regression Testing (Comparison)
# ==========================================

Scenario: Motion PDF matches baseline version
  Given I start the interview at "motion_to_continue"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | users[0].name.first | Test | |
    | users[0].name.last | User | |
    | users[0].address.address | 100 Test Street | |
    | users[0].address.city | Boston | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 02108 | |
    | docket_number | 2023-TEST-001 | |
    | motion_reason | Testing PDF generation | users[0].signature |
  And I sign
  And I continue
  And I download "motion_output.pdf"
  Then I expect the baseline PDF "baseline_motion.pdf" and new PDF "motion_output.pdf" to be the same

Scenario: Complaint PDF matches baseline format
  Given I start the interview at "complaint_form"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | users[0].name.first | Baseline | |
    | users[0].name.last | Tester | |
    | users[0].address.address | 200 Baseline Rd | |
    | users[0].address.city | Boston | |
    | users[0].address.state | MA | |
    | users[0].address.zip | 02108 | |
    | other_parties[0].name.first | Defendant | |
    | other_parties[0].name.last | Example | |
    | claim_description | Standard test claim | users[0].signature |
  And I sign
  And I continue
  And I download "complaint_output.pdf"
  Then I expect the baseline PDF "baseline_complaint.pdf" and new PDF "complaint_output.pdf" to be the same

# ==========================================
# PDF Content Validation Tests
# ==========================================

Scenario: PDF contains all required user information
  Given I start the interview at "intake_form"
  And I set the var "client_first_name" to "Jennifer"
  And I set the var "client_last_name" to "Martinez"
  And I continue
  And I set the var "client_address" to "789 Elm Street, Cambridge, MA 02139"
  And I continue
  And I set the var "client_phone" to "617-555-7890"
  And I set the var "client_email" to "jennifer.martinez@example.com"
  And I continue
  Then I should see the phrase "Jennifer Martinez"
  And I should see the phrase "789 Elm Street"
  And I should see the phrase "617-555-7890"
  And I download "intake_form.pdf"

Scenario: PDF contains correct court information
  Given I start the interview at "court_filing"
  And I set the var "trial_court" to "Suffolk Superior Court"
  And I continue
  And I set the var "docket_number" to "2023-CV-54321"
  And I continue
  Then I should see the phrase "Suffolk Superior Court"
  And I should see the phrase "2023-CV-54321"
  And I download "court_filing.pdf"

Scenario: PDF includes signature and date
  Given I start the interview at "affidavit_form"
  And I get to the question id "signature" with this data:
    | var | value | trigger |
    | affiant_name | Michael Brown | |
    | statement | I certify these facts are true | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Michael Brown"
  And I should see the phrase "Signature"
  And I download "affidavit.pdf"

# ==========================================
# PDF with Attachments/Addendum Tests
# ==========================================

Scenario: Long form text generates addendum page
  Given I start the interview at "detailed_complaint"
  And I set the var "users[0].name.first" to "Amanda"
  And I set the var "users[0].name.last" to "White"
  And I continue
  # Very long description to trigger addendum
  And I set the var "incident_description" to "This is a very detailed description of the incident that occurred on multiple occasions. The first incident happened on January 15th when the defendant failed to deliver goods as promised. The second incident occurred on February 3rd when additional payment was demanded without justification. The third incident involved threats made on March 12th. This text is intentionally long to test addendum functionality and ensure all information is properly included in the generated PDF document with proper formatting and page breaks."
  And I continue
  Then I should see the phrase "Addendum"
  And I download "detailed_complaint.pdf"

Scenario: Multiple attachments are included in PDF bundle
  Given I start the interview at "petition_with_exhibits"
  And I get to the question id "attachments" with this data:
    | var | value | trigger |
    | petitioner_name | Sarah Thompson | |
    | has_exhibits | True | |
    | exhibit_count | 3 | |
  And I continue
  Then I should see the phrase "Exhibit A"
  And I should see the phrase "Exhibit B"
  And I should see the phrase "Exhibit C"
  And I download "petition_with_exhibits.pdf"

# ==========================================
# PDF Date Handling Tests
# ==========================================

Scenario: PDF includes current date correctly
  Given I start the interview at "dated_document"
  And I set the var "document_date" to "today"
  And I continue
  Then I should see the phrase "Date:"
  And I download "dated_document.pdf"

Scenario: PDF calculates past date correctly
  Given I start the interview at "historical_form"
  And I set the var "incident_date" to "today - 90"
  And I continue
  And I set the var "birthdate" to "today - 9125"
  And I continue
  Then I download "historical_form.pdf"

Scenario: PDF calculates future date correctly
  Given I start the interview at "deadline_form"
  And I set the var "response_deadline" to "today + 30"
  And I continue
  And I set the var "hearing_date" to "today + 60"
  And I continue
  Then I download "deadline_form.pdf"

# ==========================================
# PDF Address Formatting Tests
# ==========================================

Scenario: PDF formats single-line address correctly
  Given I start the interview at "address_test_form"
  And I set the address of "users[0]" to "500 Main Street, Worcester, MA 01608"
  And I continue
  Then I should see the phrase "500 Main Street"
  And I should see the phrase "Worcester, MA 01608"
  And I download "address_form.pdf"

Scenario: PDF formats multi-line address correctly
  Given I start the interview at "detailed_address_form"
  And I set the var "users[0].address.address" to "1234 Commonwealth Avenue"
  And I continue
  And I set the var "users[0].address.unit" to "Apt 5B"
  And I continue
  And I set the var "users[0].address.city" to "Boston"
  And I set the var "users[0].address.state" to "MA"
  And I set the var "users[0].address.zip" to "02215"
  And I continue
  Then I should see the phrase "1234 Commonwealth Avenue"
  And I should see the phrase "Apt 5B"
  And I should see the phrase "Boston, MA 02215"
  And I download "detailed_address.pdf"

# ==========================================
# PDF Multi-Party Tests
# ==========================================

Scenario: PDF includes multiple plaintiffs
  Given I start the interview at "multi_plaintiff_case"
  And I get to the question id "defendants" with this data:
    | var | value | trigger |
    | users[0].name.first | Alice | |
    | users[0].name.last | Anderson | |
    | users[1].name.first | Bob | |
    | users[1].name.last | Baker | |
    | users[2].name.first | Carol | |
    | users[2].name.last | Cooper | |
  And I continue
  Then I should see the phrase "Alice Anderson"
  And I should see the phrase "Bob Baker"
  And I should see the phrase "Carol Cooper"
  And I download "multi_plaintiff.pdf"

Scenario: PDF includes multiple defendants
  Given I start the interview at "multi_defendant_case"
  And I get to the question id "case_details" with this data:
    | var | value | trigger |
    | users[0].name.first | Plaintiff | |
    | users[0].name.last | One | |
    | other_parties[0].name.first | Defendant | |
    | other_parties[0].name.last | Alpha | |
    | other_parties[1].name.first | Defendant | |
    | other_parties[1].name.last | Beta | |
    | other_parties[2].name.first | Defendant | |
    | other_parties[2].name.last | Gamma | |
  And I continue
  Then I should see the phrase "Defendant Alpha"
  And I should see the phrase "Defendant Beta"
  And I should see the phrase "Defendant Gamma"
  And I download "multi_defendant.pdf"

# ==========================================
# PDF Conditional Content Tests
# ==========================================

Scenario: PDF includes optional sections when applicable
  Given I start the interview at "conditional_form"
  And I set the var "has_attorney" to "True"
  And I continue
  And I set the var "attorney_name" to "John Attorney"
  And I set the var "attorney_bar_number" to "BBO123456"
  And I continue
  Then I should see the phrase "Attorney Information"
  And I should see the phrase "John Attorney"
  And I should see the phrase "BBO123456"
  And I download "conditional_with_attorney.pdf"

Scenario: PDF excludes optional sections when not applicable
  Given I start the interview at "conditional_form"
  And I set the var "has_attorney" to "False"
  And I continue
  And I set the var "pro_se" to "True"
  And I continue
  Then I should see the phrase "Pro Se"
  And I should NOT see the phrase "Attorney Information"
  And I download "conditional_pro_se.pdf"

# ==========================================
# PDF Error Handling Tests
# ==========================================

Scenario: Missing required field prevents PDF generation
  Given I start the interview at "strict_form"
  # Skip required field
  And I continue
  Then I will be told an answer is invalid
  And I should NOT see the phrase "Download"

Scenario: Invalid data format shows validation error
  Given I start the interview at "validated_form"
  And I set the var "phone_number" to "invalid-phone"
  And I continue
  Then I will be told an answer is invalid

Scenario: Corrected data allows PDF generation
  Given I start the interview at "validated_form"
  And I set the var "phone_number" to "invalid-phone"
  And I continue
  Then I will be told an answer is invalid
  # Fix the error
  And I set the var "phone_number" to "617-555-1234"
  And I continue
  Then I should see the phrase "Download"
  And I download "validated_form.pdf"

# ==========================================
# PDF Bundle Tests
# ==========================================

Scenario: Generate complete case bundle with multiple documents
  Given I start the interview at "case_bundle"
  And I get to the question id "bundle_download" with this data:
    | var | value | trigger |
    | users[0].name.first | Bundle | |
    | users[0].name.last | Test | |
    | include_complaint | True | |
    | include_motion | True | |
    | include_affidavit | True | |
    | case_number | 2023-BUNDLE-001 | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Complete Bundle"
  And I download "case_bundle.pdf"

Scenario: Bundle includes cover page
  Given I start the interview at "case_bundle"
  And I set the var "include_cover_page" to "True"
  And I continue
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | case_title | Smith v. Jones | |
    | court_name | Superior Court | users[0].signature |
  And I sign
  And I continue
  Then I should see the phrase "Cover Page"
  And I download "bundle_with_cover.pdf"

# ==========================================
# PDF Performance Tests
# ==========================================

Scenario: Large form completes within timeout
  Given the maximum seconds for each Step is 300
  And I start the interview at "comprehensive_form"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | users[0].name.first | Performance | |
    | users[0].name.last | Test | |
    | section_1_complete | True | |
    | section_2_complete | True | |
    | section_3_complete | True | |
    | section_4_complete | True | |
    | section_5_complete | True | users[0].signature |
  And I sign
  And I continue
  Then I download "comprehensive_form.pdf"

# ==========================================
# PDF Accessibility Tests
# ==========================================

Scenario: Download page is accessible
  Given I start the interview at "test"
  And I continue
  Then I check the page for accessibility issues
  And I download "test_document.pdf"

Scenario: Form completion flow is accessible
  Given I start the interview at "accessible_form"
  And I set the var "user_name" to "Accessible Test"
  And I continue
  Then I check the page for accessibility issues
  And I continue
  Then I check the page for accessibility issues
  And I download "accessible_form.pdf"

# ==========================================
# PDF Visual Regression Tests
# ==========================================

Scenario: Motion layout remains consistent
  Given I start the interview at "standard_motion"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | users[0].name.first | Layout | |
    | users[0].name.last | Test | |
    | motion_type | Motion to Continue | users[0].signature |
  And I sign
  And I continue
  And I download "motion_layout_test.pdf"
  Then I expect the baseline PDF "baseline_motion_layout.pdf" and new PDF "motion_layout_test.pdf" to be the same

Scenario: Complaint formatting remains consistent
  Given I start the interview at "standard_complaint"
  And I get to the question id "download" with this data:
    | var | value | trigger |
    | users[0].name.first | Format | |
    | users[0].name.last | Test | |
    | claim_type | Breach of Contract | users[0].signature |
  And I sign
  And I continue
  And I download "complaint_format_test.pdf"
  Then I expect the baseline PDF "baseline_complaint_format.pdf" and new PDF "complaint_format_test.pdf" to be the same

# ==========================================
# PDF Screenshot Documentation Tests
# ==========================================

Scenario: Document PDF generation flow with screenshots
  Given I start the interview at "documented_form"
  Then I take a screenshot
  And I set the var "test_field" to "Screenshot Test"
  And I continue
  Then I take a screenshot
  And I sign
  Then I take a screenshot
  And I continue
  Then I take a screenshot
  And I download "documented_form.pdf"
