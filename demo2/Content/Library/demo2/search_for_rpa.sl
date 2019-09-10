namespace: demo2
operation:
  name: search_for_rpa
  outputs:
  - return_result: ${return_result}
  - error_message: ${error_message}
  sequential_action:
    gav: com.microfocus.seq:demo2.search_for_rpa:1.0.0
    steps:
    - step:
        id: '1'
        object_path: Browser("Google").Page("Google").WebEdit("Search")
        action: Set
        default_args: '"rpa"'
        snapshot: .\Snapshots\ssf1.html
        highlight_id: '10000000'
    - step:
        id: '2'
        object_path: Browser("Google").Page("Google").WebButton("Google Search")
        action: Click
        snapshot: .\Snapshots\ssf2.html
        highlight_id: '10000000'
  results:
  - SUCCESS
  - WARNING
  - FAILURE
