########################################################################################################################
#!!
#! @input instance_id: Specify AWS EC2 Instance Identifier
#! @input security_group_id: Specify AWS EC2 Security Group Identifier
#!!#
########################################################################################################################
namespace: secops
flow:
  name: secops_remediation
  inputs:
    - instance_id
    - security_group_id
  workflow:
    - modify_instance_attribute:
        do:
          io.cloudslang.amazon.aws.ec2.instances.modify_instance_attribute:
            - identity: "${get_sp('aws.identity')}"
            - credential:
                value: "${get_sp('aws.credential')}"
                sensitive: true
            - security_group_ids_string: '${security_group_id}'
            - instance_id: '${instance_id}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      modify_instance_attribute:
        x: 543
        y: 170
        navigate:
          0f76bc76-2547-51be-8dfb-f24911cfc004:
            targetId: 2980af20-cec6-3d5e-5e89-48a2d3f9d25a
            port: SUCCESS
          32b23568-12a0-0111-b3be-9ff99c3735b5:
            targetId: fbe68559-2c60-7f19-ee3d-39b063879180
            port: FAILURE
    results:
      FAILURE:
        fbe68559-2c60-7f19-ee3d-39b063879180:
          x: 543
          y: 391
      SUCCESS:
        2980af20-cec6-3d5e-5e89-48a2d3f9d25a:
          x: 771
          y: 180
