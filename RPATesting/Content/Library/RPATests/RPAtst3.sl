namespace: RPATests
flow:
  name: RPAtst3
  inputs:
    - filename: "\\test123.txt"
    - script: "${'get-content C:\\Users\\Administrator\\Downloads'+filename}"
  workflow:
    - Get_Input:
        do:
          io.cloudslang.base.powershell.powershell_script:
            - host: 10.3.163.91
            - port: '5985'
            - protocol: http
            - username: administrator
            - password:
                value: Police123
                sensitive: true
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
            - script: '${script}'
        publish:
          - msg: '${return_result}'
        navigate:
          - SUCCESS: trigger_robot
          - FAILURE: on_failure
    - post_message_slack:
        do:
          io.cloudslang.demos.slack.chat.post_message:
            - text: '${"Incident created. Incident number is "+incidentnum}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
    - trigger_robot:
        do:
          uft.trigger_robot:
            - host: 10.3.163.91
            - port: '5985'
            - protocol: http
            - username: administrator
            - password: Police123
            - is_robot_visible: 'True'
            - robot_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest6"
            - robot_results_path: "C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest6\\OOresults"
            - robot_parameters: "${'Param1:'+msg}"
            - rpa_workspace_path: "C:\\Users\\shoaibh\\Documents\\OOExecution"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: Get_Output
    - Get_Output:
        do:
          io.cloudslang.base.powershell.powershell_script:
            - host: 10.3.163.91
            - port: '5985'
            - protocol: http
            - username: administrator
            - password:
                value: Police123
                sensitive: true
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
            - script: "select-xml -path \"C:\\Users\\shoaibh\\Documents\\Unified Functional Testing\\GUITest6\\OOresults\\Report\\run_results.xml\" -xpath \"//OutputParameters\" | foreach {$_.node.Innerxml}"
        publish:
          - incidentnum: "${return_result.split('Param2\"',1)[-1].split('value=\"',1)[-1].split('\"',1)[0]}"
        navigate:
          - SUCCESS: post_message_slack
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      Get_Input:
        x: 82
        y: 160
      post_message_slack:
        x: 795
        y: 156
        navigate:
          412e2cf5-fee2-fd43-20f6-3a4632aa96f1:
            targetId: 03b4edb7-467d-0705-3e37-979484195f43
            port: SUCCESS
      trigger_robot:
        x: 316
        y: 159
      Get_Output:
        x: 543
        y: 159
    results:
      SUCCESS:
        03b4edb7-467d-0705-3e37-979484195f43:
          x: 1017
          y: 180
