namespace: RPATests
flow:
  name: RPAtst2
  inputs:
    - host: 10.3.163.91
    - username: administrator
    - password:
        default: Police123
        sensitive: true
    - port: '5985'
    - protocol: http
    - msg: ticket creation
  workflow:
    - trigger_robottst:
        do:
          RPATests.subflows.trigger_robottst:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password: '${password}'
            - is_robot_visible: 'False'
            - robot_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest4"
            - robot_results_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest4\\OOResults"
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
      trigger_robottst:
        x: 236
        y: 141
        navigate:
          4f6c1850-b99e-5524-7c7d-d29fd2632c5c:
            targetId: ad737f48-0df3-4d56-ab02-3e24ce168bfe
            port: SUCCESS
          f9a511ac-eab1-4230-9811-ac6f6eb54262:
            targetId: fcd4f52e-a2aa-5a2f-034f-6b69758a848a
            port: FAILURE
    results:
      FAILURE:
        fcd4f52e-a2aa-5a2f-034f-6b69758a848a:
          x: 267.0138854980469
          y: 390.03125
      SUCCESS:
        ad737f48-0df3-4d56-ab02-3e24ce168bfe:
          x: 598.013916015625
          y: 113.03125
