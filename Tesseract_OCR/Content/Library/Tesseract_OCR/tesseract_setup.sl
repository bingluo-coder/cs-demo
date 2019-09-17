namespace: Tesseract_OCR
flow:
  name: tesseract_setup
  workflow:
    - tesseract_setup:
        do:
          io.cloudslang.tesseract.ocr.utils.tesseract_setup:
            - data_path: "C:\\Users\\Administrator\\Desktop\\OCR"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      tesseract_setup:
        x: 221
        'y': 148
        navigate:
          fc6ee306-26c1-df0e-4303-28635c2a5e06:
            targetId: a911b163-e3e1-2994-9780-a10b26fe0426
            port: SUCCESS
    results:
      SUCCESS:
        a911b163-e3e1-2994-9780-a10b26fe0426:
          x: 410
          'y': 143
