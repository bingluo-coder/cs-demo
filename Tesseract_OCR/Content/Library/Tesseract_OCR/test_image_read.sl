namespace: Tesseract_OCR
flow:
  name: test_image_read
  workflow:
    - extract_text_from_image:
        do:
          io.cloudslang.tesseract.ocr.extract_text_from_image:
            - file_path: "C:\\Users\\Administrator\\Desktop\\data\\test1.jpg"
            - data_path: "C:\\Users\\Administrator\\Desktop\\OCR"
            - language: ENG
            - text_blocks: 'false'
            - deskew: 'true'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_text_from_image:
        x: 400
        'y': 225
        navigate:
          f76a59ed-9bee-0bbd-ae41-95d22285ae43:
            targetId: 90d05a35-fcc8-cece-e964-9634cde5dc43
            port: SUCCESS
    results:
      SUCCESS:
        90d05a35-fcc8-cece-e964-9634cde5dc43:
          x: 630
          'y': 251
