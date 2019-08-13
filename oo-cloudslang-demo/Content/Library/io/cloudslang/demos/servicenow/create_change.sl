########################################################################################################################
#!!
#! @description: Creates a change in Service Now.
#!
#! @input description: Change description
#!
#! @output number: Number of the created incident
#!
#! @result SUCCESS: Flow completed successfully.
#! @result FAILURE: Failure occurred during execution.
#!!#
########################################################################################################################

namespace: io.cloudslang.demos.servicenow
flow:
  name: create_change
  inputs:
    - description: Amazon deployment issue
  workflow:
    - create_change:
        do:
          io.cloudslang.demo.sub_flows.create_record:
            - host: "${get_sp('servicenow.host')}"
            - username: "${get_sp('servicenow.username')}"
            - password:
                value: "${get_sp('servicenow.password')}"
                sensitive: true
            - table_name: change_request
            - body: "${\"{'short_description':'\"+description+\"','impact':'1','urgency':'1','category': 'Hardware','approval': 'Approved'}\"}"
        publish:
          - json_output: '${return_result}'
          - system_id
          - error_message
          - return_code
          - status_code
        navigate:
          - SUCCESS: parse_number
          - REST_POST_API_CALL_FAILURE: FAILURE
          - GET_SYSID_FAILURE: FAILURE
    - parse_number:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${json_output}'
            - json_path: $.result.number
        publish:
          - number: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - number
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      parse_number:
        x: 400
        y: 125
        navigate:
          e43fb55e-de97-a7d3-0327-d8b8bc735615:
            targetId: e7117108-4978-a8c2-41d4-4461e5d4fe89
            port: SUCCESS
      create_change:
        x: 100
        y: 250
        navigate:
          d8662442-3769-ce42-0a72-d2c283a90d96:
            targetId: e7820c6a-d21b-9951-b9ee-5b12d30abb32
            port: REST_POST_API_CALL_FAILURE
          ceebf48c-a778-3bb8-f587-bed1a86cc678:
            targetId: e7820c6a-d21b-9951-b9ee-5b12d30abb32
            port: GET_SYSID_FAILURE
    results:
      SUCCESS:
        e7117108-4978-a8c2-41d4-4461e5d4fe89:
          x: 700
          y: 250
      FAILURE:
        e7820c6a-d21b-9951-b9ee-5b12d30abb32:
          x: 400
          y: 375
