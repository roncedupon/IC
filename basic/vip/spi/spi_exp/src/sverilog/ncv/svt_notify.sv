//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_NOTIFY_SV
`define GUARD_SVT_NOTIFY_SV

/**
 * This macro can be used to configure a basic notification, independent of the
 * base technology.
 */
`define SVT_NOTIFY_CONFIGURE(methodname,stateclass,notifyname,notifykind) \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_NOTIFY_BASE_TYPE vmm_notify
`else
`define SVT_NOTIFY_BASE_TYPE svt_notify
`endif

// =============================================================================
/**
 * Base class for a shared notification service that may be needed by some
 * protocol suites.  An example of where this may be used would be in
 * a layered protocol, where timing information between the protocol layers
 * needs to be communicated.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_notify extends vmm_notify;
`else
class svt_notify;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
   /**
    * Enum used to provide compatibility layer for supporting vmm_notify notify types in UVM/OVM.
    */
   typedef enum int {ONE_SHOT = 2,
                     BLAST    = 3,
                     ON_OFF   = 5
                     } sync_e;

   /**
    * Enum used to provide compatibility layer for supporting vmm_notify reset types in UVM/OVM.
    */
   typedef enum bit {SOFT,
                     HARD} reset_e;
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Array used to map from notification string to the associated notify ID.
   */
  local int notification_map[string];

//svt_vipdk_exclude
  local int notification_associated_skip_file[int];
  local int notification_skip_next[int];

//svt_vipdk_end_exclude
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * The event pool that provides and manages the actual UVM/OVM events.
   */
  local `SVT_XVM(event_pool) event_pool = null;

  /**
   * Array which can be used to VMM style sync events to UVM/OVM 'wait' calls.
   */
  local sync_e sync_map[int];

  /**
   * Variable used to support automatic generation of unique notification IDs.
   * Initialized to 1_000_000 reserving all prior IDs for use by client.
   */
   local int last_notification_id = 1000000;
`endif

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class, passing the
   * appropriate argument values to the <b>vmm_notify</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log, string suite_name);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class.
   *
   * @param reporter Reporter object to route messages through.
   * 
   * @param suite_name Passed in to identify the model suite.
   * 
   * @param event_pool
   */
  extern function new(`SVT_XVM(report_object) reporter, string suite_name, `SVT_XVM(event_pool) event_pool = null);
`endif

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Z/NiYBLTJa+o3t/JtAnYjtBkDJpOC2fdJiyDwhSeKSzbZCd6CEOt+oUVNe2ZizQ3
dKCuUPJQ0KQHFho3uYI+vkOc3L8VHJnnaIisYFFnnZotQVKbcglQR1as437h4vZL
68+6Hw+ZD/RIxwTzlnt6gV+1SJ4eHI6TvUnXFozRYIq0xBw4IBIqYQ==
//pragma protect end_key_block
//pragma protect digest_block
y6ot7b3iYnV4Shn5J7s7ljt55i0=
//pragma protect end_digest_block
//pragma protect data_block
l2v+ZI+C6lNVfWqrsnzLtNcyJvpcALJa+CzfiHhhGaHgay8N4UFzYOZWUncqJU4j
9cz6VlCxrG3hjtJvY/1Rw2d0NKv5bahFYZoPfO38QAIhegx4quAzlyBm+5dLof+2
7zJHi1sAiZA9MUrQ4ocqsi7pRSA8mgrqdb+KhSilMPg0KXLUofjTAzr52NvcUh2q
/XNz9e/l/N6UFwRl3GBgPaxpNEPvMsuLMPUnkPcKlNes062W69DbClOCdb2CSSx6
6uA9UaiDtGjcdK/WddQKJG8Wax6sPUt7XjqbEC6yyGs+IIm8TX7vCg+B0xpHXwCj
mIT8SGFUXSVxhbYYViVaLuwxpNJbPo/u1EfY2GkigE8Fw+MOBes+ekjlUixzl8ad
HfVOsJJ1AQcLyE81CcqG8mtqshMpR65IY+pEm7Muh41rKUaypNVlt+ctNlpX9zgb
XSZsrG12yL9a9GfzeUSYwvQqiiVm4McAgL8OcBt5fmEy1LmzqPmSSOFywHdvbtOF
Id9S0SmHJt86amepWwvwAN9VKgs61A5hTbhl12lp+A24ckWJmkqCIzHXISrguRm0
3sDJCnuL9EgKP/XhN/0tBiiJ6E/f4eYghXXUk9WIJCs2SLHKQpqbJ9UusLwUNd2d
uBMOqZ3p4ZU/uJ2wWVm5i7ro5flThZMOpb+MIOe1N9XUfxF3K0vyE7cyPlrURd7k
fGNlM1X3v03+TVqGOGgQ2wKqLFHMzqUZ/NbLsAPjZXGWXGQsFBj32VdvmCx5vlbs
jAx0AXdFSnbj1dXNONB7bVDeL1ZqkS2YVKcdkflWpMFllzpgSky3M9OTy0MeDrLc
u73FjJYLZ/7DFa1Win52FSzdIK8SeNjTqz0NILDs5E+Mq/aYl9i3q/kQM8VlmhgZ
ulRiSdhkoUKpUDEWdRNs7qUT6VeGxmP0E940SBF6J5h7StVyYdHcZV9tF6Rk7Lj+
8NvTtIvcWqnZ2vLJ7ibukayptXGBQx7q6etxs4I52XXWF9FFu8QPfzjIJS357ubt
VmH0tudhP6Uc/cWzomkBYbxt11Z9NSnXCKv4r/ph0mjV45ENlMCRMMswLFoEZWdm
mFwz/FmwD5ar64y/fF2BkyV1UoNPab471Pv8K4k//nwPTNCSynxR124o5m/Ra9C2
5ywo1tfNeFZaFf4jMqaVvmbAgXYZo3k+CBf3fH9aBlC1J2GF1lPhzmwprDShjQSh
pjYbUtX7iyp2omohwLKpDJ8TbDpn/O+9eCa9mENQ7TjeeF9JuI6MuD+/NRRPTEMV
A3HY3hFZ3V0awLnJ7u1V3CK//jL50PiOTRZre+VHDZ0LOZu+daghEpCxxexoJZEj

//pragma protect end_data_block
//pragma protect digest_block
2Svp+m+9zWabSdbeLLVrZqvybmM=
//pragma protect end_digest_block
//pragma protect end_protected

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM.
   * Used to provide VMM style notification capabilities in UVM/OVM.
   */
  extern virtual function int configure(int notification_id = -1, sync_e sync = ONE_SHOT);

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM,
   * while associating the notification to a specific UVM/OVM event. Used to provide
   * VMM style notification capabilities in UVM/OVM, tied to well known specific UVM/OVM
   * events.
   */
  extern virtual function int configure_event_notify(int notification_id = -1, sync_e sync = ONE_SHOT, `SVT_XVM(event) xvm_ev = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to check whether the indicated notification has been configured.
   */
  extern virtual function int is_configured(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether the indification notification is currently on.
   */
  extern virtual function bit is_on(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to wait for the indicate notification to go to OFF.
   */
  extern virtual task wait_for_off(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to get the `SVT_XVM(object) associated with the indicated notification.
   */
   extern virtual function `SVT_DATA_BASE_TYPE status(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to trigger a notification event.
   */
  extern virtual function void indicate(int notification_id,
                           `SVT_XVM(object) status = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to reset an edge event.
   */
  extern virtual function void reset(int notification_id = -1, reset_e rst_typ = HARD);
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification and to establish a string identifier
   * which can be used to obtain the numeric identifier for the notification.
   */
  extern virtual function int configure_named_notify( string name, int notification_id = -1, sync_e sync = ONE_SHOT, int skip_file = 0);

  //----------------------------------------------------------------------------
  /**
   * Gets the notification Id associated with the indicated name, as specified
   * via a previous call to configure_named_notify.
   *
   * @param name Name associated with the notification.
   *
   * @return Notification ID which can be used to access the named notification.
   */
  extern virtual function int get_notification_id(string name);

  //----------------------------------------------------------------------------
  /**
   * Gets the name associated with the indicated notification ID, as specified
   * via a previous call to configure_named_notify.
   *
   * @param notification_id ID associated with the notification.
   *
   * @return Notification name which has been specified.
   */
  extern virtual function string get_notification_name(int notification_id);

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void log_to_logger(int log_file_id, bit notifications_described, svt_logger logger);

  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void mcd_skip_next(int notification_id, int log_file_id);

//svt_vipdk_end_exclude
  // ---------------------------------------------------------------------------
endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JKAHmC9sFJ+CBsVs8biR8Td1hYvKBgHToiV+ePMuJ58uO8ADdqlDIIedMcFCK78O
6NQqGbv1KdTSkVyovpfyPcyoGb7EXy4pDVbFryj75hNiCyl7X7wYPz8T/Qaw5pdM
eOuZMjTvU7HSQvj5ORgI8LS14m3wBmIcMOF+oGv91ON1PQV52IxPQw==
//pragma protect end_key_block
//pragma protect digest_block
JYcJ24eXUhNyOCuz6SbrJcqmy5E=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
1gy+6/x0ncKOSIFpXtb4VA4oESc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_NOTIFY_SV
