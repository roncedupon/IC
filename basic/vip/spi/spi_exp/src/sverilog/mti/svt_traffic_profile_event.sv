//=======================================================================
// COPYRIGHT (C) 2016 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------
`ifndef GUARD_SVT_TRAFFIC_PROFILE_EVENT_SV
`define GUARD_SVT_TRAFFIC_PROFILE_EVENT_SV
/**
  * Class used to store additional information required for 
  * synchronization of multiple traffic profiles using input and
  * output events
  */
`ifdef SVT_UVM_TECHNOLOGY
class svt_traffic_profile_event extends uvm_event;
`elsif SVT_OVM_TECHNOLOGY
class svt_traffic_profile_event extends ovm_event;
`endif

  typedef enum bit {
    INPUT_EVENT = `SVT_TRAFFIC_PROFILE_INPUT_EVENT,
    OUTPUT_EVENT = `SVT_TRAFFIC_PROFILE_OUTPUT_EVENT
  } event_direction_enum; 

  typedef enum bit[1:0] {
    END_OF_PROFILE = `SVT_TRAFFIC_PROFILE_END_OF_PROFILE,
    FRAME_TIME = `SVT_TRAFFIC_PROFILE_END_OF_FRAME_TIME,    
    FRAME_SIZE = `SVT_TRAFFIC_PROFILE_END_OF_FRAME_SIZE   
  } output_event_type_enum;

  /** Name of the group corresponding to this event */
  string group_name;

  /**
   * Integer that identifies the sequence number of this group. All profiles of
   * the same group must have the same sequence number. Groups that have the
   * least sequence number will be executed first before other groups.
   */
  int group_seq_number;

  /**
   * The traffic profile associated with this event. Can use the data field in
   * uvm_event as well
   */
  `SVT_TRANSACTION_TYPE causal_traffic_profile; 

  /** Indicates direction of event */
  event_direction_enum event_direction;
  
  /**
   * Indicates when the output event is triggered, if this is an output event
   * Can be end_of_profile, end_of_frame_time, end_of_frame_size or
   * end_of_addr_range These properties are explained in the event
   * co-ordination traffic profile format
   */
  output_event_type_enum output_event_type; 

  /**
   * Valid if output_event_type is end_of_frame_time. 
   * Indicates the number of cycles after which the corresponding output_event
   * must be triggered. The event is triggered after every frame_time number
   * of cycles
   */
  int frame_time; 

  /**
   * Valid if output_event_type is end_of_frame_size
   * Indicates the number of bytes after which the corresponding output_event
   * must be triggered. The event is triggered after every frame_size number
   * of bytes are transmitted. 
   */
  int frame_size; 

  extern function new();
endclass

function svt_traffic_profile_event::new();
  super.new();
endfunction
`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DU+7E4ZhfxlY4DMbTixj9EpA0qsKuqyJ133YfNFUIWMh7KkKEeTlPj6Y1bsV2+Qw
tGogizu+bH79iWvHORXARBXtnLkP2h8OxYnmWNKl890aSYnyAiufm3zwlNLKAxh+
iRY7oZEX3wFYvoYHcd5sdEE9pJQDIBArbs5MQaeOnfI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 83        )
RjARHVOYJjgn7uo0qMPJrCntWN3T4S3zCc7WJsldp4GBZhHddytIpjJZdXIRmctj
HutmKI+IySdGySqBRHD+IqaQ8BIlPRWp0aJXYaiX/dIl/ipXvOfRX385Yh379VxI
`pragma protect end_protected
