namespace: demo2
flow:
  name: search_for_rpa_flow
  workflow:
  - search_for_rpa:
      do:
        demo2.search_for_rpa: []
      publish:
      - return_result
      - error_message
      navigate:
      - SUCCESS: SUCCESS
      - WARNING: SUCCESS
      - FAILURE: on_failure
  outputs:
  - return_result
  - error_message
  results:
  - SUCCESS
  - FAILURE
