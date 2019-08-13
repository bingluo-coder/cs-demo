namespace: RPATests.subflows
flow:
  name: pstest1
  workflow:
    - powershell_script:
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
          - incidentnumber: "${return_result.split('Param2\"',1)[-1].split('value=\"',1)[-1].split('\"',1)[0]}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      powershell_script:
        x: 207
        y: 175
        navigate:
          708ed651-516d-b33a-bccc-ca0814d68636:
            targetId: 03597318-644e-ed88-962d-ea664056405c
            port: SUCCESS
          c680f112-5a18-d928-aa42-1d236acb5ff3:
            targetId: f5074781-6e19-d329-af03-76cea2b638b0
            port: FAILURE
    results:
      FAILURE:
        f5074781-6e19-d329-af03-76cea2b638b0:
          x: 222.01388549804688
          y: 377.03125
      SUCCESS:
        03597318-644e-ed88-962d-ea664056405c:
          x: 570.013916015625
          y: 162.03125
