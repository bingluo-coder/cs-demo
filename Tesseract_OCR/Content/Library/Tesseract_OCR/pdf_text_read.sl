namespace: Tesseract_OCR
flow:
  name: pdf_text_read
  workflow:
    - extract_text_from_pdf:
        do:
          io.cloudslang.tesseract.ocr.extract_text_from_pdf:
            - file_path: "C:\\Users\\Administrator\\Desktop\\data\\HPE VSR1000 Virtual Services Router LISP Configuration Guide.pdf"
            - data_path: "C:\\Users\\Administrator\\Desktop\\OCR"
            - language: ENG
            - from_page: '1'
            - to_page: '4'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_text_from_pdf:
        x: 390
        'y': 165
        navigate:
          600026cd-9e39-5f6a-3d35-3e2f975b4842:
            targetId: 22a21090-3c4b-2429-41de-1d6397ef8862
            port: SUCCESS
    results:
      SUCCESS:
        22a21090-3c4b-2429-41de-1d6397ef8862:
          x: 601
          'y': 175
