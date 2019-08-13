namespace: RPATests
flow:
  name: RPAtst4loop
  workflow:
    - RPAtst3:
        loop:
          for: "x in '0,1'"
          do:
            RPATests.RPAtst3:
              - filename: "\\test2.txt"
              - script: "${'get-content C:\\Users\\Administrator\\Downloads'+filename+' | select -index '+x}"
          break:
            - FAILURE
        navigate:
          - FAILURE: FAILURE
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      RPAtst3:
        x: 213
        y: 152
        navigate:
          fac56eef-613a-25f1-95f7-948f89691c3b:
            targetId: b35d2000-f723-b7ea-4acf-f81b3b962862
            port: SUCCESS
          70babf1c-a081-7a05-8954-46967abcde9a:
            targetId: 385bbcbf-5ab4-bd29-9f8b-e2584bbfc59e
            port: FAILURE
    results:
      SUCCESS:
        b35d2000-f723-b7ea-4acf-f81b3b962862:
          x: 532.013916015625
          y: 213.03125
      FAILURE:
        385bbcbf-5ab4-bd29-9f8b-e2584bbfc59e:
          x: 227.01388549804688
          y: 367.03125
