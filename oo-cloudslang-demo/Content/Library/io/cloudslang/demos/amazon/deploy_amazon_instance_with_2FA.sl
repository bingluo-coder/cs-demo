########################################################################################################################
#!!
#! @description: This flow launches a new EC2 instance.
#!
#! @output instance_id: The ID of the newly created instance
#! @output exception: Exception if there was an error when executing, empty otherwise
#! @output message: The user message in case 2 Factor Authentication fails
#!
#! @result SUCCESS: The server (instance) was successfully deployed
#!!#
########################################################################################################################

namespace: io.cloudslang.demos.amazon
flow:
  name: deploy_amazon_instance_with_2FA
  inputs:
    - secret:
        default: EGEg4we12XrH
        required: false
    - user:
        default: hcm_user
        private: true
  workflow:
    - no_secret_provided:
        do:
          io.cloudslang.base.utils.is_null:
            - variable: '${secret}'
        navigate:
          - IS_NULL: set_message_to_user_no_key
          - IS_NOT_NULL: validate_secret_with_vault_value
    - validate_secret_with_vault_value:
        do:
          io.cloudslang.demos.security.match_existing_key_pair_in_vault:
            - user: '${user}'
            - private_key: '${secret}'
        navigate:
          - FAILURE: set_message_to_user_invalid_key
          - SUCCESS: deploy_ec2_instance
    - deploy_ec2_instance:
        do:
          io.cloudslang.amazon.aws.ec2.deploy_instance:
            - identity: "${get_sp('amazon.identity')}"
            - credential:
                value: "${get_sp('amazon.credential')}"
                sensitive: true
            - image_id: "${get_sp('amazon.image_id')}"
            - key_tags_string: "${get_sp('amazon.key_tags_strings')}"
            - security_group_ids_string: sg-869f4ff0
            - value_tags_string: "${get_sp('amazon.value_tags_strings')}"
            - instance_type: "${get_sp('amazon.instance_type')}"
        publish:
          - instance_id
          - return_result
          - exception
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - set_message_to_user_no_key:
        do:
          io.cloudslang.demos.generic.do_nothing:
            - input_0: You need to provide secret key in order to trigger the flow. Contact your administrator or follow the process to request a secret key.
        publish:
          - message: '${input_0}'
        navigate:
          - SUCCESS: NO_SECRET
    - set_message_to_user_invalid_key:
        do:
          io.cloudslang.demos.generic.do_nothing:
            - input_0: "${'The provided secret key: ' + secret + ' is not valid or expired. Request a new key'}"
        publish:
          - message: '${input_0}'
        navigate:
          - SUCCESS: INVALID_SECRET
  outputs:
    - instance_id: '${instance_id}'
    - exception: '${exception}'
    - message: '${message}'
  results:
    - SUCCESS
    - FAILURE
    - INVALID_SECRET
    - NO_SECRET
extensions:
  graph:
    steps:
      no_secret_provided:
        x: 399
        y: 27
      validate_secret_with_vault_value:
        x: 183
        y: 124
      deploy_ec2_instance:
        x: 347
        y: 247
        navigate:
          b48f4942-f46d-caa4-b0f7-377ee70cc655:
            targetId: c6d0b661-5bbc-7ae4-56f5-a28e8edc0a59
            port: SUCCESS
      set_message_to_user_no_key:
        x: 551
        y: 122
        navigate:
          6512a841-c5cf-547f-a62d-d7e3c54b02b9:
            targetId: 5aee10fb-59af-da8e-d3be-fd909b3fa621
            port: SUCCESS
      set_message_to_user_invalid_key:
        x: 27
        y: 235
        navigate:
          53259885-a55f-c34a-095b-6624b646f4a1:
            targetId: 16eda65a-4377-2260-a24e-aa5d4bd8a46d
            port: SUCCESS
    results:
      SUCCESS:
        c6d0b661-5bbc-7ae4-56f5-a28e8edc0a59:
          x: 557
          y: 356
      INVALID_SECRET:
        16eda65a-4377-2260-a24e-aa5d4bd8a46d:
          x: 183
          y: 356
      NO_SECRET:
        5aee10fb-59af-da8e-d3be-fd909b3fa621:
          x: 745
          y: 217
