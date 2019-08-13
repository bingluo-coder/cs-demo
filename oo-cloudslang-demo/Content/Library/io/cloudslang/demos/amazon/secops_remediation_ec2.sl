########################################################################################################################
#!!
#! @input instance_id: Specify your EC2 Instance ID to remediate
#!!#
########################################################################################################################
namespace: io.cloudslang.demos.amazon
flow:
  name: secops_remediation_ec2
  inputs:
    - instance_id: i-0716acacd1dacdcce
  workflow:
    - create_incident:
        do:
          io.cloudslang.demos.servicenow.create_incident:
            - description: rbc-demo-hacked AWS Security Group changed
        navigate:
          - SUCCESS: modify_instance_attribute
          - FAILURE: FAILURE
    - modify_instance_attribute:
        do:
          io.cloudslang.amazon.aws.ec2.instances.modify_instance_attribute:
            - identity: "${get_sp('amazon.identity')}"
            - credential:
                value: "${get_sp('amazon.credential')}"
                sensitive: true
            - security_group_ids_string: sg-66b16110
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
      create_incident:
        x: 259
        y: 173
        navigate:
          4b23d60c-6468-bf96-8ac4-3aa101b35b95:
            targetId: fbe68559-2c60-7f19-ee3d-39b063879180
            port: FAILURE
      modify_instance_attribute:
        x: 543
        y: 169
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
          x: 358
          y: 384
      SUCCESS:
        2980af20-cec6-3d5e-5e89-48a2d3f9d25a:
          x: 790
          y: 162
