namespace: Salesforce
operation:
  name: Order
  inputs:
    - username
    - password:
        sensitive: true
    - account_name
    - order_date
    - contract_number
    - description
  sequential_action:
    gav: 'com.microfocus.seq:Salesforce.Order:1.0.0'
    steps:
      - step:
          id: '1'
          object_path: 'Browser("登录 | Salesforce").Page("登录 | Salesforce").WebEdit("username")'
          action: Set
          default_args: '"robin2056-sfb4@force.com"'
          snapshot: ".\\Snapshots\\ssf1.html"
          highlight_id: '10000000'
          args: 'Parameter("username")'
      - step:
          id: '2'
          object_path: 'Browser("登录 | Salesforce").Page("登录 | Salesforce").WebEdit("pw")'
          action: SetSecure
          default_args: '"vf!qaP59Fbgguaz"'
          snapshot: ".\\Snapshots\\ssf2.html"
          highlight_id: '10000000'
          args: 'Parameter("password")'
      - step:
          id: '3'
          object_path: 'Browser("登录 | Salesforce").Page("登录 | Salesforce").WebButton("登录")'
          action: Click
          snapshot: ".\\Snapshots\\ssf3.html"
          highlight_id: '10000000'
      - step:
          id: '10'
          object_path: 'Browser("登录 | Salesforce").Page("Salesforce - Professional").Link("Orders")'
          action: Click
          snapshot: ".\\Snapshots\\ssf10.html"
          highlight_id: '10000000'
      - step:
          id: '11'
          object_path: 'Browser("登录 | Salesforce").Page("Orders: Home ~ Salesforce").WebButton("New")'
          action: Click
          snapshot: ".\\Snapshots\\ssf11.html"
          highlight_id: '10000000'
      - step:
          id: '12'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").Image("Company Authorized By")'
          action: FireEvent
          default_args: '"onmouseover"'
          snapshot: ".\\Snapshots\\ssf12.html"
          highlight_id: '10000000'
      - step:
          id: '13'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").Image("Company Authorized By")'
          action: FireEvent
          default_args: '"onmouseover"'
          snapshot: ".\\Snapshots\\ssf13.html"
          highlight_id: '10000000'
      - step:
          id: '14'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").Image("Customer Authorized By")'
          action: FireEvent
          default_args: '"onmouseover"'
          snapshot: ".\\Snapshots\\ssf14.html"
          highlight_id: '10000000'
      - step:
          id: '15'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").WebEdit("accid")'
          action: Set
          default_args: '"Delta"'
          snapshot: ".\\Snapshots\\ssf15.html"
          highlight_id: '10000000'
          args: 'Parameter("account_name")'
      - step:
          id: '16'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").WebEdit("EffectiveDate")'
          action: Set
          default_args: '"10/9/2019"'
          snapshot: ".\\Snapshots\\ssf16.html"
          highlight_id: '10000000'
          args: 'Parameter("order_date")'
      - step:
          id: '24'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").WebEdit("Contract")'
          action: Set
          default_args: '"00000101"'
          snapshot: ".\\Snapshots\\ssf24.html"
          highlight_id: '10000000'
          args: 'Parameter("contract_number")'
      - step:
          id: '25'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").WebEdit("Description")'
          action: Set
          default_args: '"Ordering for bootcamp"'
          snapshot: ".\\Snapshots\\ssf25.html"
          highlight_id: '10000000'
          args: 'Parameter("description")'
      - step:
          id: '29'
          object_path: 'Browser("登录 | Salesforce").Page("New Order ~ Salesforce").WebButton("Save_2")'
          action: Click
          snapshot: ".\\Snapshots\\ssf29.html"
          highlight_id: '10000000'
      - step:
          id: '32'
          object_path: 'Browser("登录 | Salesforce").Page("Order 00000100 ~ Salesforce").WebElement("Order 00000100")'
          action: Output
          default_args: 'CheckPoint("order_number")'
  outputs:
    - order_number:
        robot: true
        value: '${order_number}'
    - return_result: '${return_result}'
    - error_message: '${error_message}'
  results:
    - SUCCESS
    - WARNING
    - FAILURE
