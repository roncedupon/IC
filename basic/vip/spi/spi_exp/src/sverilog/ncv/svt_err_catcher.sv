//=======================================================================
// COPYRIGHT (C) 2014-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_ERR_CATCHER_SV 
`define GUARD_SVT_ERR_CATCHER_SV

`ifndef SVT_VMM_TECHNOLOGY

//========================================================================
/**
 * This file creates a UVM/OVM message catcher class to demote expected error
 * and warnings.
 * 
 * The add_message_text_to_demote() method is used to add a
 * regex expression to match the message text of ERROR or WARNING messages
 * to be demoted.
 * 
 * The #add_message_id_to_demote() method is used to add a
 * regex expression to match the message id of ERROR or WARNING messages
 * to be demoted.
 * 
 * Any ERROR or WARNING message or ID that matches these expressions are
 * demoted to INFO level messages.  The number of times that a message or id
 * is demoted is tracked in the #demoted_messages_count and the
 * #demoted_id_count arrays.
 */
class svt_err_catcher extends svt_report_catcher;

  /** Typedef for a queue of strings */
  typedef string string_q_t[$];
   
  /**
   * Array to store the number of times that a particular message text has been demoted.
   */
  protected int demoted_messages_count[string];

  /**
   * Array to store the number of times that a particular message id has been demoted.
   */
  protected int demoted_id_count[string];

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Queue that contains regex expressions to identify message text to be
   * demoted.  Multiple messages can be demoted by pushing multiple values
   * to the queue.
   */
  protected string_q_t messages_to_demote;

  /**
   * Queue that contains regex expressions to identify message ID to be
   * demoted.  Multiple messages can be demoted by pushing multiple values
   * to the queue.
   */
  protected string_q_t ids_to_demote;

  /**
   * Array to store the number of times that a particular ERROR message will be demoted
   * before the message filter is disabled.
   */
  protected int demoted_messages_limit[string];

  /**
   * Array to store the number of times that a particular WARNING message will be demoted
   * before the message filter is disabled.
   */
  protected int demoted_id_limit[string];

  /**
   * #messages_to_demote entries that have been removed via a call to
   * remove_message_text_to_demote().  These are retained so that they can be used
   * to summarize the report catcher activity.
   */
  protected string_q_t messages_to_demote_removed;

  /**
   * #ids_to_demote entries that have been removed via a call to
   * remove_message_id_to_demote().  These are retained so that they can be used
   * to summarize the report catcher activity.
   */
  protected string_q_t ids_to_demote_removed;

  /**
   * Flag that determines whether the limit check should be executed on message
   * text entries that have been removed.
   */
  protected bit messages_to_demote_removed_limit_check[string];

  /**
   * Flag that determines whether the limit check should be executed on message
   * ID entries that have been removed.
   */
  protected bit ids_to_demote_removed_limit_check[string];

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_xvm_object_utils(svt_err_catcher)


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Constructor */
  extern function new(string name="svt_err_catcher");

  // ---------------------------------------------------------------------------
  /**
   * Adds a new regex entry that will be used to match against the message text
   * of every ERROR and WARNING message.
   * 
   * The limit argument of this method will restrict the error catcher to demote
   * the message text the number of times provided.  After this number of demotions
   * is reached then the message will continue to be issued as normal.  A limit
   * value of 0 indicates no limit (all matching message text observed will be
   * demoted).
   * 
   * Multiple calls of this method with the same message text will result in updates
   * to the limit value for this message text.  If a limit value of 0 is supplied in
   * a subsequent call then the limit will be reset back to 0 (unlimited).
   * Positive values received will increase the limit value and negative values will
   * decrease the limit value.  If the limit value is modified to be equal to 0 by a
   * subsequent call then the message text demotion for this text will be removed.
   * 
   * Errors will be generated if the limit is set to a value of less than 0, either
   * in the first call or in subsequent calls.
   * 
   * @param msg Regex expression used to match the message text
   * 
   * @param limit Number of times that the message text is demoted before the message
   * filter is disabled.  A value of 0 will cause all messages to be demoted (no limit).
   */
  extern function void add_message_text_to_demote(string msg, int limit = 0);

  // ---------------------------------------------------------------------------
  /**
   * Adds a new regex entry that will be used to match against the message ID
   * of every ERROR and WARNING message.
   * 
   * The limit argument of this method will restrict the error catcher to demote
   * the message ID the number of times provided.  After this number of demotions
   * is reached then the message will continue to be issued as normal.  A limit
   * value of 0 indicates no limit (all matching message IDs observed will be
   * demoted).
   * 
   * Multiple calls of this method with the same message ID will result in updates
   * to the limit value for this message ID.  If a limit value of 0 is supplied in
   * a subsequent call then the limit will be reset back to 0 (unlimited).
   * Positive values received will increase the limit value and negative values will
   * decrease the limit value.  If the limit value is modified to be equal to 0 by a
   * subsequent call then the message ID demotion for this ID will be removed.
   * 
   * Errors will be generated if the limit is set to a value of less than 0, either
   * in the first call or in subsequent calls.
   * 
   * @param id Regex expression used to match the message id
   * 
   * @param limit Number of times that the message id is demoted before the message
   * filter is disabled.  A value of 0 will cause all messages to be demoted (no limit).
   */
  extern function void add_message_id_to_demote(string id, int limit = 0);

  // ---------------------------------------------------------------------------
  /**
   * Removes an existing entry from the message text to demote queue. The string
   * value must be an exact match for an existing entry or an error message is
   * generated.
   * 
   * By default the limit check associated with this message text entry is also
   * removed.  This check can be retained using the retain_limit_check argument.
   * 
   * @param msg Message text to demote entry to be removed
   * 
   * @param retain_limit_check Optional argument that allows the limit check for this
   * message ID to be retained
   */
  extern function void remove_message_text_to_demote(string msg, bit retain_limit_check = 0);

  // ---------------------------------------------------------------------------
  /**
   * Removes an existing entry from the message ID to demote queue. The string
   * value must be an exact match for an existing entry or an error message is
   * generated.
   * 
   * By default the limit check associated with this message text entry is also
   * removed.  This check can be retained using the retain_limit_check argument.
   * 
   * @param id Message ID to demote entry to be removed
   * 
   * @param retain_limit_check Optional argument that allows the limit check for this
   * message ID to be retained
   */
  extern function void remove_message_id_to_demote(string id, bit retain_limit_check = 0);

  // ---------------------------------------------------------------------------
  /**
   * Analyzes all expected message and ID demotions and returns 1 if all expected
   * messages were demoted, and 0 if any expected messages were not detected.
   * 
   * @param silent Controls whether each missing message is displayed
   * 
   * @return Status of all expected message demotions.  Return value of 1 indicates
   * that all expected messages were observed, and 0 indicates that not all messages
   * were observed.
   */
  extern function bit report(bit silent = 0);

  // ---------------------------------------------------------------------------
  /**
   * Returns the queue of message text entries that have been submitted.
   * 
   * @return Queue of strings that have been submitted to demote message text
   */
  extern function string_q_t get_messages_to_demote();

  // ---------------------------------------------------------------------------
  /**
   * Returns the queue of message ID entries that have been submitted.
   * 
   * @return Queue of strings that have been submitted to demote message ID
   */
  extern function string_q_t get_ids_to_demote();

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of times that a message has been demoted.
   * 
   * @param msg Message text that was used in the call to add_message_text_to_demote()
   * 
   * @return number of times that the message has been demoted
   */
  extern function int get_demoted_messages_count(string msg);

  // ---------------------------------------------------------------------------
  /**
   * Returns the number of times that a message ID has been demoted.
   * 
   * @param id Message ID text that was used in the call to add_message_id_to_demote()
   * 
   * @return number of times that the message ID has been demoted
   */
  extern function int get_demoted_id_count(string id);

  // ---------------------------------------------------------------------------
  /**
   * Returns the demotion limit that has been set up for this message text.
   * 
   * @param msg Message text that was used in the call to add_message_text_to_demote()
   * 
   * @return number of times that the message will be demoted
   */
  extern function int get_demoted_messages_limit(string msg);

  // ---------------------------------------------------------------------------
  /**
   * Returns the demotion limit that has been set up for this message ID.
   * 
   * @param id Message ID text that was used in the call to add_message_id_to_demote()
   * 
   * @return number of times that the message ID will be demoted
   */
  extern function int get_demoted_id_limit(string id);

  // ---------------------------------------------------------------------------
  /** UVM/OVM catch() method implementation */
  extern function svt_err_catcher::action_e catch();

endclass: svt_err_catcher

// =============================================================================

// -----------------------------------------------------------------------------
function svt_err_catcher::new(string name="svt_err_catcher");
  super.new(name);
endfunction: new

// -----------------------------------------------------------------------------
function void svt_err_catcher::add_message_text_to_demote(string msg, int limit = 0);
  int index_q[$];

  // Add or update the limit entry
  if (demoted_messages_limit.exists(msg)) begin
    if (limit == 0) begin
      demoted_messages_limit[msg] = 0;
    end
    else if (demoted_messages_limit[msg] + limit == 0) begin
      // If a negative value is passed in which brings the limit value to 0, then
      // remove the message demotion entirely (since 0 represent "no limit") and return
      demoted_messages_limit.delete(msg);
      remove_message_text_to_demote(msg, 1);
      return;
    end
    else if (demoted_messages_limit[msg] + limit < 0) begin
      `svt_xvm_error("add_message_text_to_demote", $sformatf("Unable to reduce the limit beyond the original setting for `%s`.  Original limit: %0d, Requested limit change: %0d", msg, demoted_messages_limit[msg], limit));
      return;
    end
    else begin
      demoted_messages_limit[msg] += limit;
    end
  end
  else begin
    if (limit < 0) begin
      `svt_xvm_error("add_message_text_to_demote", $sformatf("Unable to establish a negative limit: %0d received", limit));
      return;
    end
    demoted_messages_limit[msg] = limit;
    // Make sure we initialize the count, so that it exists.
    demoted_messages_count[msg] = 0;
  end

  // Find if an entry already exists
  index_q = messages_to_demote.find_first_index(q_msg) with (q_msg == msg);
  if (index_q.size() == 0) begin
    messages_to_demote.push_back(msg);
  end

  // If the message text was previously removed, then remove the entry from the
  // removed list
  foreach (messages_to_demote_removed[i]) begin
    if (messages_to_demote_removed[i] == msg) begin
      messages_to_demote_removed.delete(i);
      break;
    end
  end
endfunction

// -----------------------------------------------------------------------------
function void svt_err_catcher::add_message_id_to_demote(string id, int limit = 0);
  int index_q[$];

  // Add or update the limit entry
  if (demoted_id_limit.exists(id)) begin
    if (limit == 0) begin
      demoted_id_limit[id] = 0;
    end
    else if (demoted_id_limit[id] + limit == 0) begin
      // If a negative value is passed in which brings the limit value to 0, then
      // remove the id demotion entirely (since 0 represent "no limit") and return
      demoted_id_limit.delete(id);
      remove_message_id_to_demote(id, 1);
      return;
    end
    else if (demoted_id_limit[id] + limit < 0) begin
      `svt_xvm_error("add_message_id_to_demote", $sformatf("Unable to reduce the limit beyond the original setting for `%s`.  Original limit: %0d, Requested limit change: %0d", id, demoted_id_limit[id], limit));
      return;
    end
    else begin
      demoted_id_limit[id] += limit;
    end
  end
  else begin
    if (limit < 0) begin
      `svt_xvm_error("add_message_id_to_demote", $sformatf("Unable to establish a negative limit: %0d received", limit));
      return;
    end
    demoted_id_limit[id] = limit;
  end

  // Find if an entry already exists
  index_q = ids_to_demote.find_first_index(q_id) with (q_id == id);
  if (index_q.size() == 0) begin
    ids_to_demote.push_back(id);
  end

  // If the message id was previously removed, then remove the entry from the
  // removed list
  foreach (ids_to_demote_removed[i]) begin
    if (ids_to_demote_removed[i] == id) begin
      ids_to_demote_removed.delete(i);
      break;
    end
  end

endfunction

// -----------------------------------------------------------------------------
function void svt_err_catcher::remove_message_text_to_demote(string msg, bit retain_limit_check = 0);
  foreach (messages_to_demote[i]) begin
    if (messages_to_demote[i] == msg) begin
      messages_to_demote.delete(i);
      messages_to_demote_removed.push_back(msg);
      if (retain_limit_check) begin
        messages_to_demote_removed_limit_check[msg] = 1;
      end
      return;
    end
  end

  //If we dropped through the list traversal then we didn't find the message
  `svt_xvm_error("remove_message_text_to_demote", $sformatf("Unable to find `%s` in the message text to demote queue", msg));
endfunction

// -----------------------------------------------------------------------------
function void svt_err_catcher::remove_message_id_to_demote(string id, bit retain_limit_check = 0);
  foreach (ids_to_demote[i]) begin
    if (ids_to_demote[i] == id) begin
      ids_to_demote.delete(i);
      ids_to_demote_removed.push_back(id);
      if (retain_limit_check) begin
        ids_to_demote_removed_limit_check[id] = 1;
      end
      return;
    end
  end

  //If we dropped through the list traversal then we didn't find the id
  `svt_xvm_error("remove_message_id_to_demote", $sformatf("Unable to find `%s` in the message id to demote queue", id));
endfunction

// -----------------------------------------------------------------------------
function bit svt_err_catcher::report(bit silent = 0);
  bit catcher_status = 1;

  foreach (messages_to_demote[msg]) begin
    if (demoted_messages_limit[messages_to_demote[msg]] == 0) begin
      if (demoted_messages_count[messages_to_demote[msg]] == 0) begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message text `%s` was not detected", messages_to_demote[msg]));
        end
        catcher_status = 0;
      end
      else begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message text `%s` was detected %0d times", messages_to_demote[msg], demoted_messages_count[messages_to_demote[msg]]));
        end
      end
    end
    else begin
      if (!silent) begin
        `svt_xvm_note("report", $sformatf("Message text `%s` was detected %0d times (expected %0d)", messages_to_demote[msg], demoted_messages_count[messages_to_demote[msg]], demoted_messages_limit[messages_to_demote[msg]]));
      end
      if (demoted_messages_limit[messages_to_demote[msg]] != demoted_messages_count[messages_to_demote[msg]]) begin
        catcher_status = 0;
      end
    end
  end

  foreach (ids_to_demote[id]) begin
    if (demoted_id_limit[ids_to_demote[id]] == 0) begin
      if (demoted_id_count[ids_to_demote[id]] == 0) begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message ID `%s` was not detected", ids_to_demote[id]));
        end
        catcher_status = 0;
      end
      else begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message ID `%s` was detected %0d times", ids_to_demote[id], demoted_id_count[ids_to_demote[id]]));
        end
      end
    end
    else begin
      if (!silent) begin
        `svt_xvm_note("report", $sformatf("Message ID `%s` was detected %0d times (expected %0d)", ids_to_demote[id], demoted_id_count[ids_to_demote[id]], demoted_id_limit[ids_to_demote[id]]));
      end
      if (demoted_id_limit[ids_to_demote[id]] != demoted_id_count[ids_to_demote[id]]) begin
        catcher_status = 0;
      end
    end
  end

  foreach (messages_to_demote_removed[msg]) begin
    if (demoted_messages_limit[messages_to_demote_removed[msg]] == 0) begin
      if (demoted_messages_count[messages_to_demote_removed[msg]] == 0) begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message text `%s` was removed, and was not detected", messages_to_demote_removed[msg]));
        end
        if (messages_to_demote_removed_limit_check.exists(msg)) begin
          catcher_status = 0;
        end
      end
      else begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message text `%s` was removed, and was detected %0d times", messages_to_demote_removed[msg], demoted_messages_count[messages_to_demote_removed[msg]]));
        end
      end
    end
    else begin
      if (!silent) begin
        `svt_xvm_note("report", $sformatf("Message text `%s` was removed, and was detected %0d times (expected %0d)", messages_to_demote_removed[msg], demoted_messages_count[messages_to_demote_removed[msg]], demoted_messages_limit[messages_to_demote_removed[msg]]));
      end
      if (messages_to_demote_removed_limit_check.exists(msg) && demoted_messages_limit[messages_to_demote[msg]] != demoted_messages_count[messages_to_demote[msg]]) begin
        catcher_status = 0;
      end
    end
  end

  foreach (ids_to_demote_removed[id]) begin
    if (demoted_id_limit[ids_to_demote_removed[id]] == 0) begin
      if (demoted_id_count[ids_to_demote_removed[id]] == 0) begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message ID `%s` was removed, and was not detected", ids_to_demote_removed[id]));
        end
        if (ids_to_demote_removed_limit_check.exists(id)) begin
          catcher_status = 0;
        end
      end
      else begin
        if (!silent) begin
          `svt_xvm_note("report", $sformatf("Message ID `%s` was removed, and was detected %0d times", ids_to_demote_removed[id], demoted_id_count[ids_to_demote_removed[id]]));
        end
      end
    end
    else begin
      if (!silent) begin
        `svt_xvm_note("report", $sformatf("Message ID `%s` was removed, and was detected %0d times (expected %0d)", ids_to_demote_removed[id], demoted_id_count[ids_to_demote_removed[id]], demoted_id_limit[ids_to_demote_removed[id]]));
      end
      if (ids_to_demote_removed_limit_check.exists(id) && demoted_messages_limit[messages_to_demote[id]] != demoted_messages_count[messages_to_demote[id]]) begin
        catcher_status = 0;
      end
    end
  end

  return catcher_status;

endfunction: report

// ---------------------------------------------------------------------------
function svt_err_catcher::string_q_t svt_err_catcher::get_messages_to_demote();
  return messages_to_demote;
endfunction: get_messages_to_demote

// ---------------------------------------------------------------------------
function svt_err_catcher::string_q_t svt_err_catcher::get_ids_to_demote();
  return ids_to_demote;
endfunction: get_ids_to_demote

// ---------------------------------------------------------------------------
function int svt_err_catcher::get_demoted_messages_count(string msg);
  return demoted_messages_count[msg];
endfunction: get_demoted_messages_count

// ---------------------------------------------------------------------------
function int svt_err_catcher::get_demoted_id_count(string id);
  return demoted_id_count[id];
endfunction: get_demoted_id_count

// ---------------------------------------------------------------------------
function int svt_err_catcher::get_demoted_messages_limit(string msg);
  return demoted_messages_limit[msg];
endfunction: get_demoted_messages_limit

// ---------------------------------------------------------------------------
function int svt_err_catcher::get_demoted_id_limit(string id);
  return demoted_id_limit[id];
endfunction: get_demoted_id_limit

// -----------------------------------------------------------------------------
function svt_err_catcher::action_e svt_err_catcher::catch();

  if(get_severity() == `SVT_XVM_UC(ERROR) ||
     get_severity() == `SVT_XVM_UC(WARNING)) begin

    foreach(messages_to_demote[i]) begin

      // Skip this message if the message demotion limit has been reached
      if (demoted_messages_limit[messages_to_demote[i]] != 0 && demoted_messages_limit[messages_to_demote[i]] == demoted_messages_count[messages_to_demote[i]]) begin
        continue;
      end

`ifdef SVT_UVM_TECHNOLOGY
      if(!uvm_re_match(messages_to_demote[i], get_message())) begin
`elsif SVT_OVM_TECHNOLOGY
      if(ovm_is_match(messages_to_demote[i], get_message())) begin
`endif

        // Update the demotion trackers
        demoted_messages_count[messages_to_demote[i]]++;

        // Demote the error
        set_severity(`SVT_XVM_UC(INFO)); 
        set_id({get_id(), " *DEMOTED*"});

      end
    end

    foreach(ids_to_demote[i]) begin

      // Skip this message if the id demotion limit has been reached
      if (demoted_id_limit[ids_to_demote[i]] != 0 && demoted_id_limit[ids_to_demote[i]] == demoted_id_count[ids_to_demote[i]]) begin
        continue;
      end


`ifdef SVT_UVM_TECHNOLOGY
      if(!uvm_re_match(ids_to_demote[i],  get_id())) begin
`elsif SVT_OVM_TECHNOLOGY
      if(ovm_is_match(ids_to_demote[i], get_id())) begin
`endif

        // Update the demotion trackers
        demoted_id_count[ids_to_demote[i]]++;

        // Demote the error
        set_severity(`SVT_XVM_UC(INFO)); 
        set_id({get_id(), " *DEMOTED*"});

      end
    end

  end

  return THROW;  
endfunction: catch

`endif // SVT_VMM_TECHNOLOGY

`endif //GUARD_SVT_ERR_CATCHER_SV
