namespace: RPATests
flow:
  name: create_change
  inputs:
    - host: 10.3.163.91
    - username: administrator
    - password:
        default: Police123
        sensitive: true
    - port: '5985'
    - protocol: http
    - msg: testing msg from oo
  workflow:
    - trigger_robot:
        do:
          uft.trigger_robot:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password: '${password}'
            - robot_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\SMAXIntegration"
            - robot_results_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest1\\OOResults"
            - robot_parameters: "${'Param1:'+msg}"
            - rpa_workspace_path: "C:\\Users\\shoaibh\\Documents\\OOExecution"
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      trigger_robot:
        x: 221
        y: 123
        navigate:
          3f2424c3-40d8-ae65-053c-0533118c868e:
            targetId: ad737f48-0df3-4d56-ab02-3e24ce168bfe
            port: SUCCESS
          e5dcf819-2fa3-e80b-6d24-508fa9c8f44f:
            targetId: fcd4f52e-a2aa-5a2f-034f-6b69758a848a
            port: FAILURE
    results:
      FAILURE:
        fcd4f52e-a2aa-5a2f-034f-6b69758a848a:
          x: 218
          y: 295
      SUCCESS:
        ad737f48-0df3-4d56-ab02-3e24ce168bfe:
          x: 414
          y: 127
