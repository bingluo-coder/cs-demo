namespace: RPATests
flow:
  name: RPAtst1
  inputs:
    - host: 10.3.163.91
    - username: administrator
    - password:
        default: Police123
        sensitive: true
    - port: '5985'
    - protocol: http
    - initialrobotpath: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\"
  workflow:
    - get_robots:
        do:
          uft.get_robots:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password: '${password}'
            - robots_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing"
        publish:
          - allrobots: '${robots}'
        navigate:
          - SUCCESS: get_robot_parameters
          - FAILURE: FAILURE
    - get_robot_parameters:
        do:
          uft.get_robot_parameters:
            - host: '${host}'
            - port: '${port}'
            - protocol: '${protocol}'
            - username: '${username}'
            - password: '${password}'
            - robot_path: '${initialrobotpath+allrobots}'
            - rpa_workspace_path: "C:\\Users\\shoaibh\\Documents\\OOExecution"
        publish:
          - parameters
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: SUCCESS
  outputs:
    - robotsall: '${allrobots}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_robots:
        x: 239
        y: 164
        navigate:
          35b767fd-686f-b34f-c644-4dbbc0de5a59:
            targetId: f7ea917d-f9ae-0543-d528-cba733506f72
            port: FAILURE
      get_robot_parameters:
        x: 512
        y: 178
        navigate:
          8b4a40dc-1665-b2c5-6b93-53089228a8c0:
            targetId: 04c3e803-54d3-0f88-fac4-d7ca17cc0396
            port: SUCCESS
          23540757-1583-9697-7094-0fc3ac89e436:
            targetId: f7ea917d-f9ae-0543-d528-cba733506f72
            port: FAILURE
    results:
      FAILURE:
        f7ea917d-f9ae-0543-d528-cba733506f72:
          x: 327.0138854980469
          y: 434.03125
      SUCCESS:
        04c3e803-54d3-0f88-fac4-d7ca17cc0396:
          x: 814
          y: 174
