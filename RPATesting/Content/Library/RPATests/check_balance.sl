namespace: RPATests
flow:
  name: check_balance
  inputs:
    - UserId: B0001
    - Password: MFLab001
  workflow:
    - trigger_robottst:
        do:
          RPATests.subflows.trigger_robottst:
            - host: 34.209.90.121
            - port: '5985'
            - protocol: http
            - username: Administrator
            - password: MFLab001
            - is_robot_visible: 'False'
            - robot_path: "C:\\Users\\Administrator\\Documents\\Unified Functional Testing\\ES40-Terminal"
            - robot_results_path: "C:\\Users\\Administrator\\Documents\\Unified Functional Testing\\ES40-Terminal\\OOResults"
            - robot_parameters: "${'UserId:'+UserId}"
            - rpa_workspace_path: "C:\\Users\\Administrator\\Documents\\OOExecution"
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
        x: 39
        y: 130
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
          x: 38
          y: 372
      SUCCESS:
        ad737f48-0df3-4d56-ab02-3e24ce168bfe:
          x: 406
          y: 135
