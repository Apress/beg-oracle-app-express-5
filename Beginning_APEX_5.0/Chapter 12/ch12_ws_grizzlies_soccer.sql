set define off
set verify off
set serveroutput on size 1000000
set feedback off
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK
begin wwv_flow.g_import_in_progress := true; end;
/
 
 
--application/set_environment
prompt  WEBSHEET APPLICATION 146 - Grizzlies Soccer
--
-- Websheet Application Export:
--   Application:     146
--   Name:            Grizzlies Soccer
--   Date and Time:   13:18 Tuesday August 18, 2015
--   Exported By:     APRESS
--   Export Type:     Websheet Application Export
--   Version:         5.0.0.00.31
--   Instance ID:     113859798334361
--   Websheet Schema: APRESS
--
-- Import:
--   Using Application Builder
--   or
--   Using SQL*Plus as the Oracle user Websheet schema, APRESS
 
-- Application Statistics:
--   Pages:                  4
--   Data Grids:             2
--   Reports:                0
 
 
--
-- ORACLE
--
-- Application Express (APEX)
--
prompt  Set Credentials...
 
begin
 
  -- Assumes you are running the script connected to SQL*Plus as the Websheet schema, APRESS.
  wwv_flow_api.set_security_group_id(p_security_group_id=>nvl(wwv_flow_application_install.get_workspace_id,121633611648859398));
 
end;
/

begin wwv_flow.g_import_in_progress := true; end;
/
begin

select value into wwv_flow_api.g_nls_numeric_chars from nls_session_parameters where parameter='NLS_NUMERIC_CHARACTERS';

end;

/
begin execute immediate 'alter session set nls_numeric_characters=''.,''';

end;

/
begin wwv_flow.g_browser_language := 'en'; end;
/
prompt  Check Compatibility...
 
begin
 
-- This date identifies the minimum version required to import this file.
wwv_flow_api.set_version(p_version_yyyy_mm_dd=>'2013.01.01');
 
end;
/

prompt  Set Application ID...
 
begin
 
   -- SET APPLICATION ID
   wwv_flow.g_ws_app_id := nvl(wwv_flow_application_install.get_application_id,146);
   wwv_flow_api.g_id_offset := nvl(wwv_flow_application_install.get_offset,0);
 
end;
/

prompt  ...Remove Websheet Application
--application/delete_application
 
begin
 
-- remove internal metadata
wwv_flow_api.remove_ws_app(nvl(wwv_flow_application_install.get_application_id,146));
-- remove websheet metadata
wwv_flow_ws_import_api.remove_ws_components(nvl(wwv_flow_application_install.get_application_id,146));
 
end;
/

prompt  ...Create Websheet Application
--application/create_ws_app
begin
    wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
 
end;
/

begin
wwv_flow_api.create_ws_app(
  p_id    => nvl(wwv_flow_application_install.get_application_id,146),
  p_name  => 'Grizzlies Soccer',
  p_owner => nvl(wwv_flow_application_install.get_schema,'APRESS'),
  p_description => '',
  p_status => 'AVAILABLE',
  p_date_format => 'DD-MON-YYYY',
  p_language => 'en',
  p_territory => 'AMERICA',
  p_home_page_id => 123624015010323160+wwv_flow_api.g_id_offset,
  p_auth_id => 123624186960323160+wwv_flow_api.g_id_offset,
  p_acl_type => 'CUSTOM',
  p_login_url => '',
  p_logout_url => '',
  p_allow_sql_yn => 'Y',
  p_show_reset_passwd_yn => 'Y',
  p_allow_public_access_yn => 'N',
  p_logo_type => 'TEXT',
  p_logo_text => 'Grizzlies Soccer',
  p_varchar2_table => wwv_flow_api.g_varchar2_table,
  p_email_from => '');
----------------
  wwv_flow_api.create_ws_app_sug_objects (
    p_id => 123624317071359939+wwv_flow_api.g_id_offset,
    p_ws_app_id => nvl(wwv_flow_application_install.get_application_id,146),
    p_object_name => 'TUSERS',
    p_object_comment => '',
    p_last_updated_by => 'APRESS',
    p_last_updated_on => to_date('201508181147','YYYYMMDDHH24MI'),
    p_created_by => 'APRESS',
    p_created_on => to_date('201508181147','YYYYMMDDHH24MI'));
 
end;
/

----------------
--package app map
--
prompt  ...Create Access Control List
begin
wwv_flow_ws_import_api.create_acl (
  p_id => 39337354977106714313070827364459465362+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_username => 'MARTIN',
  p_priv => 'A'
  );
 
end;
/

begin
wwv_flow_ws_import_api.create_acl (
  p_id => 39350971263643423457859103740431140725+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_username => 'CHRIS',
  p_priv => 'R'
  );
 
end;
/

begin
wwv_flow_ws_import_api.create_acl (
  p_id => 39350971263644632383678718369605846901+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_username => 'CAMERON',
  p_priv => 'C'
  );
 
end;
/

prompt  ...Create Application Authentication Set Up
declare
  sf varchar2(32767) := null;
  vf varchar2(32767) := null;
  pre_ap varchar2(32767) := null;
  af varchar2(32767) := null;
  post_ap varchar2(32767) := null;
begin
af:=af||'return f_login ';

wwv_flow_api.create_ws_auth_setup(
  p_id => 123624186960323160+wwv_flow_api.g_id_offset,
  p_websheet_application_id => wwv_flow.g_ws_app_id,
  p_name => 'Custom Authentication',
  p_invalid_session_url => 'f?p=4900:101:&SESSION.::NO::WS_APP_ID,P900_ID:&WS_APP_ID.,&P900_ID.&p_lang=&APP_SESSION_LANG.&p_territory=&APP_SESSION_TERRITORY.',
  p_auth_function => af,
  p_use_secure_cookie_yn => 'N',
  p_logout_url => 'ws?p='||wwv_flow.g_ws_app_id||':home'
  );
 
end;
/

prompt  ...Create Data Grid
declare
  q varchar2(32767) := null;
begin
q := null;
wwv_flow_api.create_ws_worksheet (
  p_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_page_id => 2,
  p_region_id => null,
  p_name => 'Schedule',
  p_max_row_count => '1000000',
  p_max_row_count_message => 'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.',
  p_no_data_found_message => 'No data found.',
  p_sql_query => q,
  p_status => 'AVAILABLE_FOR_OWNER',
  p_allow_report_saving => 'Y',
  p_allow_report_categories => 'Y',
  p_pagination_type => 'ROWS_X_TO_Y_OF_Z',
  p_pagination_display_pos => 'BOTTOM_RIGHT',
  p_show_finder_drop_down => 'Y',
  p_show_display_row_count => 'N',
  p_show_search_bar => 'Y',
  p_show_search_textbox => 'Y',
  p_show_actions_menu => 'Y',
  p_report_list_mode => 'TABS',
  p_fixed_header => 'NONE',
  p_show_select_columns => 'Y',
  p_show_filter => 'Y',
  p_show_sort => 'Y',
  p_show_control_break => 'Y',
  p_show_highlight => 'Y',
  p_show_computation => 'Y',
  p_show_aggregate => 'Y',
  p_show_chart => 'Y',
  p_show_group_by => 'Y',
  p_show_pivot => 'Y',
  p_show_calendar => 'Y',
  p_show_flashback => 'Y',
  p_show_reset => 'Y',
  p_show_download => 'Y',
  p_show_help => 'Y',
  p_show_detail_link => 'Y',
  p_download_formats => 'CSV:HTML:EMAIL',
  p_allow_exclude_null_values => 'Y',
  p_allow_hide_extra_columns => 'Y',
  p_icon_view_enabled_yn => 'N',
  p_icon_view_use_custom=>'N',
  p_detail_view_enabled_yn => 'N',
  p_show_notify => 'N',
  p_allow_save_rpt_public => 'N',
  p_show_rows_per_page => 'Y',
  p_internal_uid => 123625047765436822
  );
end;
/
begin
wwv_flow_api.create_ws_data_grid (
    p_id => 123625105129436822+wwv_flow_api.g_id_offset,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
    p_ws_report_owner => '',
    p_is_template => '',
    p_status => 'PRIVATE',
    p_websheet_type => 'DATA',
    p_websheet_name => 'Schedule',
    p_websheet_alias => 'SCHEDULE',
    p_websheet_owner => 'MARTIN',
    p_geo_resp_sep => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625255202436827+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C001',
  p_display_order => 10,
  p_data_grid_form_seq => 1,
  p_column_identifier => 'A',
  p_column_label => 'Event',
  p_report_label => 'Event',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625314468436828+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'D001',
  p_display_order => 20,
  p_data_grid_form_seq => 2,
  p_column_identifier => 'B',
  p_column_label => 'Date',
  p_report_label => 'Date',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'DATE',
  p_tz_dependent => '',
  p_display_as => 'DATE_PICKER',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 50,
  p_display_width => 30,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625464600436828+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C002',
  p_display_order => 30,
  p_data_grid_form_seq => 3,
  p_column_identifier => 'C',
  p_column_label => 'Time',
  p_report_label => 'Time',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625513536436828+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C003',
  p_display_order => 40,
  p_data_grid_form_seq => 4,
  p_column_identifier => 'D',
  p_column_label => 'Field',
  p_report_label => 'Field',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625602955436828+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C004',
  p_display_order => 50,
  p_data_grid_form_seq => 5,
  p_column_identifier => 'E',
  p_column_label => 'Against',
  p_report_label => 'Against',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625702794436828+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'N001',
  p_display_order => 60,
  p_data_grid_form_seq => 6,
  p_column_identifier => 'F',
  p_column_label => 'Grizzlies',
  p_report_label => 'Grizzlies',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'NUMBER',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'RIGHT',
  p_max_length => 40,
  p_display_width => 1,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123625837728436829+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_db_column_name => 'N002',
  p_display_order => 70,
  p_data_grid_form_seq => 7,
  p_column_identifier => 'G',
  p_column_label => 'Opponent',
  p_report_label => 'Opponent',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'NUMBER',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'RIGHT',
  p_max_length => 40,
  p_display_width => 1,
  p_display_height => null,
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C001:D001:C002:C003:C004:';

wwv_flow_api.create_ws_rpt(
  p_id => 123628887487528793+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id  => 123625105129436822+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_ALTERNATIVE',
  p_name => 'Next Two Weeks',
  p_report_seq => 10,
  p_report_alias => '1236289',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_sort_column_1 => 'D001',
  p_sort_direction_1 => 'ASC',
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123629078097528794+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123628887487528793+wwv_flow_api.g_id_offset,
  p_name =>'Next Two Weeks',
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_expr_type =>'ROW',
  p_expr =>'B >= to_date(''10-jun-2010'', ''dd-mon-yyyy'') '||chr(10)||
'        and B < to_date(''10-jun-2010'', ''dd-mon-yyyy'') + 14 '||chr(10)||
'',
  p_condition_sql =>'"D001" >= to_date(''10-jun-2010'', ''dd-mon-yyyy'')          and "D001" < to_date(''10-jun-2010'', ''dd-mon-yyyy'') + 14  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C001:D001:C002:C003:C004:';

wwv_flow_api.create_ws_rpt(
  p_id => 123629576831544809+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id  => 123625105129436822+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_ALTERNATIVE',
  p_name => 'Remaining Games',
  p_report_seq => 10,
  p_report_alias => '1236296',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_sort_column_1 => 'D001',
  p_sort_direction_1 => 'ASC',
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123629816897544809+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123629576831544809+wwv_flow_api.g_id_offset,
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_column_name =>'D001',
  p_operator =>'>=',
  p_expr =>'20100610000000',
  p_condition_sql =>'"D001" >= to_date(#APXWS_EXPR#,''YYYYMMDDHH24MISS'')',
  p_condition_display =>'#APXWS_COL_NAME# >= #APXWS_EXPR_DATE#  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123629720031544809+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123629576831544809+wwv_flow_api.g_id_offset,
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_column_name =>'C001',
  p_operator =>'=',
  p_expr =>'Game',
  p_condition_sql =>'"C001" = #APXWS_EXPR#',
  p_condition_display =>'#APXWS_COL_NAME# = ''Game''  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C001:D001:C002:C003:C004:N001:N002:';

wwv_flow_api.create_ws_rpt(
  p_id => 123631234066558533+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id  => 123625105129436822+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_ALTERNATIVE',
  p_name => 'Results',
  p_report_seq => 10,
  p_report_alias => '1236313',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_sort_column_1 => 'D001',
  p_sort_direction_1 => 'ASC',
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123631459223558533+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123631234066558533+wwv_flow_api.g_id_offset,
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_column_name =>'D001',
  p_operator =>'<=',
  p_expr =>'20100610000000',
  p_condition_sql =>'"D001" <= to_date(#APXWS_EXPR#,''YYYYMMDDHH24MISS'')',
  p_condition_display =>'#APXWS_COL_NAME# <= #APXWS_EXPR_DATE#  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123631592053558533+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123631234066558533+wwv_flow_api.g_id_offset,
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_column_name =>'C001',
  p_operator =>'=',
  p_expr =>'Game',
  p_condition_sql =>'"C001" = #APXWS_EXPR#',
  p_condition_display =>'#APXWS_COL_NAME# = ''Game''  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C001:D001:C002:C003:C004:N001:N002';

wwv_flow_api.create_ws_rpt(
  p_id => 123625949088436847+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id  => 123625105129436822+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_DEFAULT',
  p_report_seq => 10,
  p_report_alias => '1236260',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C001:D001:C002:C003:C004:';

wwv_flow_api.create_ws_rpt(
  p_id => 123630306301547876+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id  => 123625105129436822+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_ALTERNATIVE',
  p_name => 'Remaining Practices',
  p_report_seq => 10,
  p_report_alias => '1236304',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_sort_column_1 => 'D001',
  p_sort_direction_1 => 'ASC',
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123630631919547876+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123630306301547876+wwv_flow_api.g_id_offset,
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_column_name =>'D001',
  p_operator =>'>=',
  p_expr =>'20100610000000',
  p_condition_sql =>'"D001" >= to_date(#APXWS_EXPR#,''YYYYMMDDHH24MISS'')',
  p_condition_display =>'#APXWS_COL_NAME# >= #APXWS_EXPR_DATE#  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
begin
wwv_flow_api.create_ws_condition(
  p_id => 123630551565547876+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123625047765436822+wwv_flow_api.g_id_offset,
  p_websheet_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_report_id => 123630306301547876+wwv_flow_api.g_id_offset,
  p_condition_type =>'FILTER',
  p_allow_delete =>'Y',
  p_column_name =>'C001',
  p_operator =>'=',
  p_expr =>'Practice',
  p_condition_sql =>'"C001" = #APXWS_EXPR#',
  p_condition_display =>'#APXWS_COL_NAME# = ''Practice''  ',
  p_enabled =>'Y',
  p_column_format =>''
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'18:45'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977107923238890441993634171538+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAER',
  p_owner => 'MARTIN',
  p_load_order => 39337354977109132164710056622808877714,
  p_c001 => 'Practice',
  p_c002 => '18:45',
  p_c003 => 'Bottomlands',
  p_d001 => to_date('20100511000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'19:00'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977110341090529671251983583890+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAES',
  p_owner => 'MARTIN',
  p_load_order => 39337354977111550016349285881158290066,
  p_c001 => 'Practice',
  p_c002 => '19:00',
  p_c003 => 'Bottomlands',
  p_d001 => to_date('20100518000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'10:00'||chr(10)||
'FORREST LAWN'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977112758942168900510332996242+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAET',
  p_owner => 'MARTIN',
  p_load_order => 39337354977113967867988515139507702418,
  p_c001 => 'Practice',
  p_c002 => '10:00',
  p_c003 => 'Forrest Lawn',
  p_d001 => to_date('20100522000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'20:15'||chr(10)||
'AIRDRIE'||chr(10)||
'AIRDRIE'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977115176793808129768682408594+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAE1',
  p_owner => 'MARTIN',
  p_load_order => 39337354977116385719627744397857114770,
  p_c001 => 'Game',
  p_c002 => '20:15',
  p_c003 => 'Airdrie',
  p_c004 => 'Airdrie',
  p_n001 => 2,
  p_n002 => 1,
  p_d001 => to_date('20100526000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'20:15'||chr(10)||
'TOM BROOKS'||chr(10)||
'CHINOOKS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977117594645447359027031820946+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAEV',
  p_owner => 'MARTIN',
  p_load_order => 39337354977118803571266973656206527122,
  p_c001 => 'Game',
  p_c002 => '20:15',
  p_c003 => 'Tom Brooks',
  p_c004 => 'Chinooks',
  p_n001 => 2,
  p_n002 => 3,
  p_d001 => to_date('20100602000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'21:00'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977120012497086588285381233298+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAEW',
  p_owner => 'MARTIN',
  p_load_order => 39337354977121221422906202914555939474,
  p_c001 => 'Practice',
  p_c002 => '21:00',
  p_c003 => 'Bottomlands',
  p_d001 => to_date('20100604000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'19:00'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'BLIZZARD'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977122430348725817543730645650+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAEX',
  p_owner => 'MARTIN',
  p_load_order => 39337354977123639274545432172905351826,
  p_c001 => 'Game',
  p_c002 => '19:00',
  p_c003 => 'Bottomlands',
  p_c004 => 'Blizzard',
  p_n001 => 4,
  p_n002 => 1,
  p_d001 => to_date('20100608000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'13:00'||chr(10)||
'FOOTHILLS'||chr(10)||
'CALLIES'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977124848200365046802080058002+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAEY',
  p_owner => 'MARTIN',
  p_load_order => 39337354977126057126184661431254764178,
  p_c001 => 'Game',
  p_c002 => '13:00',
  p_c003 => 'Foothills',
  p_c004 => 'Callies',
  p_d001 => to_date('20100613000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'18:45'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977127266052004276060429470354+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAEZ',
  p_owner => 'MARTIN',
  p_load_order => 39337354977128474977823890689604176530,
  p_c001 => 'Practice',
  p_c002 => '18:45',
  p_c003 => 'Bottomlands',
  p_d001 => to_date('20100616000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'19:15'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'DARTS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977129683903643505318778882706+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFA',
  p_owner => 'MARTIN',
  p_load_order => 39337354977130892829463119947953588882,
  p_c001 => 'Game',
  p_c002 => '19:15',
  p_c003 => 'Bottomlands',
  p_c004 => 'Darts',
  p_d001 => to_date('20100630000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'18:45'||chr(10)||
'GLENMORE'||chr(10)||
'VIPERS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977132101755282734577128295058+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFB',
  p_owner => 'MARTIN',
  p_load_order => 39337354977133310681102349206303001234,
  p_c001 => 'Game',
  p_c002 => '18:45',
  p_c003 => 'Glenmore',
  p_c004 => 'Vipers',
  p_d001 => to_date('20100707000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'15:30'||chr(10)||
'MOUNT ROYAL'||chr(10)||
'DARTS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977134519606921963835477707410+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFC',
  p_owner => 'MARTIN',
  p_load_order => 39337354977135728532741578464652413586,
  p_c001 => 'Game',
  p_c002 => '15:30',
  p_c003 => 'Mount Royal',
  p_c004 => 'Darts',
  p_d001 => to_date('20100718000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'19:00'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'WOLVES'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977136937458561193093827119762+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFD',
  p_owner => 'MARTIN',
  p_load_order => 39337354977138146384380807723001825938,
  p_c001 => 'Game',
  p_c002 => '19:00',
  p_c003 => 'Bottomlands',
  p_c004 => 'Wolves',
  p_d001 => to_date('20100730000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'11:00'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977139355310200422352176532114+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFE',
  p_owner => 'MARTIN',
  p_load_order => 39337354977140564236020036981351238290,
  p_c001 => 'Practice',
  p_c002 => '11:00',
  p_c003 => 'Bottomlands',
  p_d001 => to_date('20100801000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'20:00'||chr(10)||
'OAKRIDGE'||chr(10)||
'ASP'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977141773161839651610525944466+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFF',
  p_owner => 'MARTIN',
  p_load_order => 39337354977142982087659266239700650642,
  p_c001 => 'Game',
  p_c002 => '20:00',
  p_c003 => 'Oakridge',
  p_c004 => 'ASP',
  p_d001 => to_date('20100809000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'21:00'||chr(10)||
'TOM BROOKS'||chr(10)||
'STORM'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977144191013478880868875356818+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFG',
  p_owner => 'MARTIN',
  p_load_order => 39337354977145399939298495498050062994,
  p_c001 => 'Game',
  p_c002 => '21:00',
  p_c003 => 'Tom Brooks',
  p_c004 => 'Storm',
  p_d001 => to_date('20100820000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'PRACTICE'||chr(10)||
'19:15'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977146608865118110127224769170+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFH',
  p_owner => 'MARTIN',
  p_load_order => 39337354977147817790937724756399475346,
  p_c001 => 'Practice',
  p_c002 => '19:15',
  p_c003 => 'Bottomlands',
  p_d001 => to_date('20100823000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'GAME'||chr(10)||
'19:15'||chr(10)||
'BOTTOMLANDS'||chr(10)||
'TIGERS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977149026716757339385574181522+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAF2',
  p_owner => 'MARTIN',
  p_load_order => 39337354977150235642576954014748887698,
  p_c001 => 'Game',
  p_c002 => '19:15',
  p_c003 => 'Bottomlands',
  p_c004 => 'Tigers',
  p_d001 => to_date('20100825000000','YYYYMMDDHH24MISS'),
  p_search_clob => sc
  );
end;
/
declare
  q varchar2(32767) := null;
begin
q := null;
wwv_flow_api.create_ws_worksheet (
  p_id => 123627938871472807+wwv_flow_api.g_id_offset,
  p_page_id => 2,
  p_region_id => null,
  p_name => 'Players',
  p_max_row_count => '1000000',
  p_max_row_count_message => 'The maximum row count for this report is #MAX_ROW_COUNT# rows.  Please apply a filter to reduce the number of records in your query.',
  p_no_data_found_message => 'No data found.',
  p_sql_query => q,
  p_status => 'AVAILABLE_FOR_OWNER',
  p_allow_report_saving => 'Y',
  p_allow_report_categories => 'Y',
  p_pagination_type => 'ROWS_X_TO_Y_OF_Z',
  p_pagination_display_pos => 'BOTTOM_RIGHT',
  p_show_finder_drop_down => 'Y',
  p_show_display_row_count => 'N',
  p_show_search_bar => 'Y',
  p_show_search_textbox => 'Y',
  p_show_actions_menu => 'Y',
  p_report_list_mode => 'TABS',
  p_fixed_header => 'NONE',
  p_show_select_columns => 'Y',
  p_show_filter => 'Y',
  p_show_sort => 'Y',
  p_show_control_break => 'Y',
  p_show_highlight => 'Y',
  p_show_computation => 'Y',
  p_show_aggregate => 'Y',
  p_show_chart => 'Y',
  p_show_group_by => 'Y',
  p_show_pivot => 'Y',
  p_show_calendar => 'Y',
  p_show_flashback => 'Y',
  p_show_reset => 'Y',
  p_show_download => 'Y',
  p_show_help => 'Y',
  p_show_detail_link => 'Y',
  p_download_formats => 'CSV:HTML:EMAIL',
  p_allow_exclude_null_values => 'Y',
  p_allow_hide_extra_columns => 'Y',
  p_icon_view_enabled_yn => 'N',
  p_icon_view_use_custom=>'N',
  p_detail_view_enabled_yn => 'N',
  p_show_notify => 'N',
  p_allow_save_rpt_public => 'N',
  p_show_rows_per_page => 'Y',
  p_internal_uid => 123627938871472807
  );
end;
/
begin
wwv_flow_api.create_ws_data_grid (
    p_id => 123628059418472807+wwv_flow_api.g_id_offset,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_worksheet_id => 123627938871472807+wwv_flow_api.g_id_offset,
    p_ws_report_owner => '',
    p_is_template => '',
    p_status => 'PRIVATE',
    p_websheet_type => 'DATA',
    p_websheet_name => 'Players',
    p_websheet_alias => 'PLAYERS',
    p_websheet_owner => 'MARTIN',
    p_geo_resp_sep => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123628101267472807+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123627938871472807+wwv_flow_api.g_id_offset,
  p_websheet_id => 123628059418472807+wwv_flow_api.g_id_offset,
  p_db_column_name => 'C001',
  p_display_order => 10,
  p_data_grid_form_seq => 1,
  p_column_identifier => 'A',
  p_column_label => 'Name',
  p_report_label => 'Name',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'STRING',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'LEFT',
  p_max_length => 4000,
  p_display_width => 30,
  p_display_height => null,
  p_allow_null => 'N',
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_column_comment => ''
  );
end;
/
begin
wwv_flow_api.create_ws_column (
  p_id => 123628224068472807+wwv_flow_api.g_id_offset,
  p_page_id => null,
  p_worksheet_id => 123627938871472807+wwv_flow_api.g_id_offset,
  p_websheet_id => 123628059418472807+wwv_flow_api.g_id_offset,
  p_db_column_name => 'N001',
  p_display_order => 20,
  p_data_grid_form_seq => 2,
  p_column_identifier => 'B',
  p_column_label => 'Goals',
  p_report_label => 'Goals',
  p_sync_form_label => 'Y',
  p_is_sortable => 'Y',
  p_allow_sorting => 'Y',
  p_allow_filtering => 'Y',
  p_allow_ctrl_breaks => 'Y',
  p_allow_aggregations => 'Y',
  p_allow_computations => 'Y',
  p_allow_charting => 'Y',
  p_allow_group_by => 'Y',
  p_allow_pivot => 'Y',
  p_allow_highlighting => 'Y',
  p_allow_hide => 'Y',
  p_allow_filters => '',
  p_others_may_edit => 'Y',
  p_others_may_view => 'Y',
  p_column_type => 'NUMBER',
  p_tz_dependent => '',
  p_display_as => 'TEXT',
  p_display_text_as => 'ESCAPE_SC',
  p_heading_alignment => 'CENTER',
  p_column_alignment => 'RIGHT',
  p_max_length => 40,
  p_display_width => 15,
  p_display_height => null,
  p_allow_null => 'N',
  p_format_mask => '',
  p_rpt_distinct_lov => 'Y',
  p_rpt_show_filter_lov => 'D',
  p_rpt_filter_date_ranges => 'ALL',
  p_default_value => 'TEXT;0',
  p_column_comment => ''
  );
end;
/
declare
    rc1 varchar2(32767) := null;
begin
rc1:=rc1||'C001:N001';

wwv_flow_api.create_ws_rpt(
  p_id => 123628330147472818+wwv_flow_api.g_id_offset,
  p_page_id=> 2,
  p_worksheet_id => 123627938871472807+wwv_flow_api.g_id_offset,
  p_websheet_id  => 123628059418472807+wwv_flow_api.g_id_offset,
  p_session_id  => null,
  p_base_report_id  => null+wwv_flow_api.g_id_offset,
  p_application_user => 'APXWS_DEFAULT',
  p_report_seq => 10,
  p_report_alias => '1236284',
  p_status => 'PUBLIC',
  p_is_default => 'Y',
  p_display_rows => 50,
  p_report_columns => rc1,
  p_flashback_enabled => 'N',
  p_calendar_display_column => ''
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'CHRIS'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977151444568396568643923593874+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123628059418472807+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFJ',
  p_owner => 'MARTIN',
  p_load_order => 39337354977152653494216183273098300050,
  p_c001 => 'Chris',
  p_n001 => 1,
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'CAMERON'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977153862420035797902273006226+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123628059418472807+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFK',
  p_owner => 'MARTIN',
  p_load_order => 39337354977155071345855412531447712402,
  p_c001 => 'Cameron',
  p_n001 => 1,
  p_search_clob => sc
  );
end;
/
declare
  sc varchar2(32767) := null;
begin
sc:=sc||'MARTIN'||chr(10)||
'';

wwv_flow_ws_import_api.create_row (
  p_id => 39337354977156280271675027160622418578+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_data_grid_id => 123628059418472807+wwv_flow_api.g_id_offset,
  p_unique_value => 'AAFL',
  p_owner => 'MARTIN',
  p_load_order => 39337354977157489197494641789797124754,
  p_c001 => 'Martin',
  p_n001 => 2,
  p_search_clob => sc
  );
end;
/
prompt  ...Create Report
 
--application/pages/page_123624015010323160
prompt  ...PAGE 123624015010323160: Home
--
begin
wwv_flow_api.create_ws_page (
    p_id => 123624015010323160+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => null+wwv_flow_api.g_id_offset,
    p_name => 'Home',
    p_upper_name => 'HOME',
    p_page_alias => '1236242',
    p_owner => 'APRESS',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Fees: Don&#39;t forget to pay your fees before the next game (13-Jun) or else you can&#39;t play!</p>'||chr(10)||
''||chr(10)||
'<p>We won our last game and are now 2-1. Check out the[[ results | Results ]]page.</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 39337354977158698123314256418971830930+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123624015010323160+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'TEXT',
   p_title => 'Important News',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39337354977159907049133871048146537106+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123624015010323160+wwv_flow_api.g_id_offset,
   p_display_sequence => 20,
   p_section_type => 'DATA',
   p_title => 'Upcoming Games and Practices',
   p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
   p_report_id => 123628887487528793+wwv_flow_api.g_id_offset,
   p_data_section_style => 2,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'Y',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>Martin scored 2 goals!</p>'||chr(10)||
''||chr(10)||
'<p>[[image: martin.jpg ]]</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 39337354977162324900773100306495949458+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123624015010323160+wwv_flow_api.g_id_offset,
   p_display_sequence => 30,
   p_section_type => 'TEXT',
   p_title => 'Player of the Week',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263641005606219874482081728373+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123624015010323160+wwv_flow_api.g_id_offset,
   p_display_sequence => 1,
   p_section_type => 'NAV_PAGE',
   p_title => 'Menu',
   p_nav_start_webpage_id => 123624015010323160+wwv_flow_api.g_id_offset,
   p_nav_max_level => 12,
   p_nav_include_link => 'Y',
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

prompt  ...Create Page
 
--application/pages/page_123633117612811074
prompt  ...PAGE 123633117612811074: Playeers
--
begin
wwv_flow_api.create_ws_page (
    p_id => 123633117612811074+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 123624015010323160+wwv_flow_api.g_id_offset,
    p_name => 'Playeers',
    p_upper_name => 'PLAYEERS',
    p_page_alias => 'PLAYERS',
    p_owner => 'MARTIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263633752051302186707033491317+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633117612811074+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'DATA',
   p_title => 'Players',
   p_data_grid_id => 123628059418472807+wwv_flow_api.g_id_offset,
   p_report_id => 123628330147472818+wwv_flow_api.g_id_offset,
   p_data_section_style => 2,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'Y',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263634960977121801336208197493+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633117612811074+wwv_flow_api.g_id_offset,
   p_display_sequence => 20,
   p_section_type => 'CHART',
   p_title => 'Goals',
   p_data_grid_id => 123628059418472807+wwv_flow_api.g_id_offset,
   p_report_id => 123628330147472818+wwv_flow_api.g_id_offset,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_type => 'COLUMN',
   p_chart_3d => 'Y',
   p_chart_label => 'C001',
   p_label_axis_title => 'Name',
   p_chart_value => 'N001',
   p_value_axis_title => 'Goals',
   p_chart_aggregate => 'SUM',
   p_chart_sorting => 'LABEL_ASC'
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263636169902941415965382903669+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633117612811074+wwv_flow_api.g_id_offset,
   p_display_sequence => 1,
   p_section_type => 'NAV_SECTION',
   p_title => 'Menu Page ',
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
c:=c||'<p>We currently have[[sqlvalue: select count(*) from tusers where active_flag = &#39;Y&#39; ]]active registered users. They are: [[sql: select initcap(user_name) &quot;Name&quot; from tusers order by user_name ]]</p>'||chr(10)||
'';

wwv_flow_ws_import_api.create_section(
   p_id => 39350971263642214532039489111256434549+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633117612811074+wwv_flow_api.g_id_offset,
   p_display_sequence => 5,
   p_section_type => 'TEXT',
   p_title => 'Active Registered Users',
   p_content => c,
   p_content_upper => upper(wwv_flow_utilities.striphtml(c)),
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'N',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_123633364604838553
prompt  ...PAGE 123633364604838553: Results
--
begin
wwv_flow_api.create_ws_page (
    p_id => 123633364604838553+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 123624015010323160+wwv_flow_api.g_id_offset,
    p_name => 'Results',
    p_upper_name => 'RESULTS',
    p_page_alias => 'RESULTS',
    p_owner => 'MARTIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263637378828761030594557609845+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633364604838553+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'DATA',
   p_title => 'Results',
   p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
   p_report_id => 123631234066558533+wwv_flow_api.g_id_offset,
   p_data_section_style => 2,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'Y',
   p_chart_sorting => ''
   );
 
end;
/

 
--application/pages/page_123633481550842673
prompt  ...PAGE 123633481550842673: Schedule
--
begin
wwv_flow_api.create_ws_page (
    p_id => 123633481550842673+wwv_flow_api.g_id_offset,
    p_page_number => null,
    p_ws_app_id => wwv_flow.g_ws_app_id,
    p_parent_page_id => 123624015010323160+wwv_flow_api.g_id_offset,
    p_name => 'Schedule',
    p_upper_name => 'SCHEDULE',
    p_page_alias => 'SCHEDULE',
    p_owner => 'MARTIN',
    p_status => '',
    p_description => ''
  );
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263638587754580645223732316021+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633481550842673+wwv_flow_api.g_id_offset,
   p_display_sequence => 10,
   p_section_type => 'DATA',
   p_title => 'Remaining Games',
   p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
   p_report_id => 123629576831544809+wwv_flow_api.g_id_offset,
   p_data_section_style => 2,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'Y',
   p_chart_sorting => ''
   );
 
end;
/

declare
  c  varchar2(32767) := null;
begin
wwv_flow_ws_import_api.create_section(
   p_id => 39350971263639796680400259852907022197+wwv_flow_api.g_id_offset,
   p_ws_app_id => wwv_flow.g_ws_app_id,
   p_webpage_id => 123633481550842673+wwv_flow_api.g_id_offset,
   p_display_sequence => 20,
   p_section_type => 'DATA',
   p_title => 'Remaining Practices',
   p_data_grid_id => 123625105129436822+wwv_flow_api.g_id_offset,
   p_report_id => 123630306301547876+wwv_flow_api.g_id_offset,
   p_data_section_style => 2,
   p_show_add_row => 'N',
   p_show_edit_row => 'N',
   p_show_search => 'Y',
   p_chart_sorting => ''
   );
 
end;
/

prompt  ...Create Annotations
begin
    wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
    wwv_flow_api.g_varchar2_table(1) := 'FFD8FFE000104A46494600010101006000600000FFDB0043000201010201010202020202020202030503030303030604040305070607070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E0F0D0C0E0B0C0C0CFFDB004301020202030303';
    wwv_flow_api.g_varchar2_table(2) := '060303060C0807080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC000110800B2007C03012200021101031101FFC4001F00000105010101010101000000000000000001';
    wwv_flow_api.g_varchar2_table(3) := '02030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A53545556';
    wwv_flow_api.g_varchar2_table(4) := '5758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F010003';
    wwv_flow_api.g_varchar2_table(5) := '0101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35';
    wwv_flow_api.g_varchar2_table(6) := '363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EA';
    wwv_flow_api.g_varchar2_table(7) := 'F2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDDCA2A266DB4C69BD2801FBC7BD31E4F5A8BCDFAD607C46F8A1A1FC24F0BCFAD788F54B5D274C8BF8E77FF58DD91075627B003F2A00E8B79F6AE3BE237C74F0AFC2FB59E7D6759B0867893FE3';
    wwv_flow_api.g_varchar2_table(8) := 'D7CF479E4C7A2673F9E2BE02FDAE3FE0A75E23F195D4F65E1297FB13C3116E8D2EB79FB6DEE17AE17E6018E00031F5E735F30EADF15B5CD53C5105ECB7F75A8FEE3EE4F02245231FF5864CB7CF82703A85C1EBD6A255226D1A323F457E277FC15234AF06';
    wwv_flow_api.g_varchar2_table(9) := 'F9DF60D065FBEBFBFBA9C6C8F3D0908338239E39AF25D7BFE0B1DAAE9775FE8BA368D7704A9FF2DD25B748FDF24E4FD00AF82FC5DF1660D2F54FF8FA8BFB6AFF00749B1332CB231FEE02320018C7017EBD6B95B1F12F88F5FD53CFB0BFBAB4F9D7CF82EA';
    wwv_flow_api.g_varchar2_table(10) := '712BFB938C941E9C64FB75AC7DB48DFD844FD10D37FE0B833DAFFC853C39A3430CAED1DABF9F3C4D27BE30FB401924B71D07535B1F0FFF00E0B95E1CD53C65343AF68D2E9D65E42C96AF6B3FDA25DDBB1DF03072318E7D8D7E637C42F8917DA0DD43F6F8';
    wwv_flow_api.g_varchar2_table(11) := 'B46BBF93EFA3C9145267B13B890C07AFCB5CFCFF0015AC754B987ECB2CBA4DEC5FBCF22744BA48D7B9538070474DA7F3A238890E58389FD12FC21F8E1E1CF8DDA0FF0069E83AA5AEA306C5F3363FCD1B1FE023B11DEBB069335FCF9FC05FDB33C55FB3ED';
    wwv_flow_api.g_varchar2_table(12) := 'D4FA9F83754B586695FE77B29C4B6F27CBC6F43E9DC1E7AF209AFD56FD827FE0A71A1FED55A5C165ACDD68DA4F882248A3F927D915EC9FC7B338C74E849EA476AE9A7523238AAD1940FADB78F7A65451DC53BCDFA568214C949E6FD29BBC552BDD72D34D';
    wwv_flow_api.g_varchar2_table(13) := 'B83134EAA57B1201A00DF66DD51BC95461F1158DD5DCD0C5756BE744FE5BA6F1BF77E7561A4CD677039AF89DF15EC7E17E837B7B7FE6F916A9E63ECFEE8EA49C80807727D715F93FFF000516FF00828A58FC50D7A1BDFB2DFF00F62E9703FF0065DAF0D1';
    wwv_flow_api.g_varchar2_table(14) := '46DD4CB273B77B70000321401EB5EC7FF059BFDB72C741B5D53C09A0CB14D7B15A88F51D9974924382B060672402376318CE0D7E3BF8D1755F1E5D5EEA77F7F2F932BF97BE3CC491B0C0210740067191C9C75ED5954ABF64EBA747DD3D36DFF6D8FB4F8C';
    wwv_flow_api.g_varchar2_table(15) := 'BEDB7F616BFBD7792E93FE7A617091EE38C2961B88C64818EF54F58FDA620D7AD67FF4AB5F3E5FBEE9BDDF69E7674F73D0639E335E4337C05D57EC907D96296EECA27F9DE0FF007B93F973CD62F883E17CFA5FFADF362837AEC7FBADF43F8FA7B5734AA5';
    wwv_flow_api.g_varchar2_table(16) := '39753AFEAF5A3EF729EBBA4FC60B1FED49A7FF0055F6F9FCC9DDFEFC99C0CB8FBC02818009C000702B2FC75F13B55FB27EEAEBFB3ECA283CB48207FB3DBDCC9B8F2E4004FCB83D49278F4AE0FC2FE18D735FBA820F36597FBE9FC7B7F2CFEB5EB1F087F6';
    wwv_flow_api.g_varchar2_table(17) := '73D57C65E479B612CDF7A4FDFA17FA71E9E8075ACEAE269C3E237A383A953E189E376BE20D56D3F7F14B2CB3CAEDBF7E5976FF007141EC7AF3CD4D67E29D734BFF008F0F37C9FF009E13FCEB1FCDD8F619E6BEDDF03FEC133EA9A5FEF6C25FDEEEDEEFF2';
    wwv_flow_api.g_varchar2_table(18) := 'F56EDC75231F4AA5E32FD816717537956B75F717640901D9B476CF1FAD79FF00DAB44F4BFB0EB729F38AEA5A1EBD753CD2EA9FD933CB1A79E899FB3DCAFF0011DA390E1B9C81CD7A27C05B783C07E7FD8354BAFB6EC96F60D452716EB27CC36247963F2A';
    wwv_flow_api.g_varchar2_table(19) := 'A82C401B99C803A115C6FC56FD976FBC1B75FF001EB2C5E57DCFFA67F37F9EB9AE2EC74BBED2F54820F36597ECBFE93027FAA4F311B90338E597B01C9AF46862232F7A279788C1CA1EECA27ECDFF00C1227FE0A6DFF0BBB54BDF87DE23BFFB5CD61FBBD3';
    wwv_flow_api.g_varchar2_table(20) := 'B517708D2617FD59FF007B0769FC2BF439AFA03FF3CBFF0064AFE777E13EAD3DAEA93F8EF4B96EB49D5254FB4A4F6BFEB64644C10E38FBA4718C7E26BDFBC7DFF0518F1FFC50F837A2D95D788E586CA58163F91C24B24FE8E700918E467F1AAC66611C3D';
    wwv_flow_api.g_varchar2_table(21) := '3F68D5CF2AA61E5F144FD73D27F680F0AEBDE28BDD17FB66C2D354B07F2DE09E744797E5CE464F22BE11FDAC7F6CCD7BC25FB4678B34CB2B5B3BBB3B1BC10C0EDFDD08BD39E99C9E38E6BE1EF1E78F355BAB6FB6EA915D5DC32A36FBA8270F71E9D4723F';
    wwv_flow_api.g_varchar2_table(22) := '3AE62FA6F1278CEFA5BC8FC416D650644714773FEB4A851C9E7B9CD7CCD5CFAAD64B9172F9DFF0318C647ED1FC25FD9D7FE10DD7BFB6B59D525BBBDD2F749E42651E3F7C03FBC27AE48AF28FF82847EDADAE7ECFBA0D97F65DD5D4565AA4D2FDAA777D92';
    wwv_flow_api.g_varchar2_table(23) := 'EE2B98E218C9190093D30057CBD6BFB5C78AB55F144FAD5D78A2FF00EDB121D9F7F7C98EB8C718FAD7927EDC5FB504FE3CF85FA2E8B2F9B341F6A7BD9AE9F0B71F37500F52EC428CF4014F6CE7A68E6942B4BEAF493474D3C3FBDEF1E75E32F8C97DE32D';
    wwv_flow_api.g_varchar2_table(24) := '52686EBFE429AA4FE65D4EFF007A3CB64807278E79EB9EF9AF56F83BFB24FF00C2796B0DEEA9179306C5F23E4FE11DF9F5EBC0AF09FD8F3E16CFF143C5135ECB6B2F93A5EED88EFBDF71EE4F1D073EF5FA35E0BB1FB2E970412C5E4F949FF01AE6CDB1D2';
    wwv_flow_api.g_varchar2_table(25) := 'A5FBB89F6F91E5D1ABFBDA9F238BD2FF0065DD0F4BB5FDD5AC5FE7FCF7AE63C69FB1EE95AF69734115AC5FBD468FEE7FF5ABE87B148292E2DFFE7957CE471B53E2E63EC3EA54E5EEF29F2F7C33FD87F4AF0BDD7EF62FFBED2BE84F86FF0008EC741F2608';
    wwv_flow_api.g_varchar2_table(26) := 'AD7FD556BDAD8FFA57FCB2AD6B75FB29FF008FAF27FF0040ACAAE2AA4FDE948BA383A70F86276FE1CD1AC6D6D7FD54556F50F0BE95743F7B6B15739A6F8B33FF002D6ACC9E20AC2532E544F37F8DDFB3CE95E32D2E7F2AD62FFBE057E757ED61F02E0F85';
    wwv_flow_api.g_varchar2_table(27) := 'FAF79F2DAFEE627F33CBE7F77FE03BD7EA9EADAB4034BAF90BF6E8D160F14785E7F37FD76C3B1D2BD5CAF1B2A752313C7CD70319D172EA7C91E0BF1341AA6833CDA34B17DF5B8F23F8F68E1F1EF819FA8ADFF889A958E97E0DD53ECB2DACBE6A25CA7C9F';
    wwv_flow_api.g_varchar2_table(28) := '3C6C783DB8EF5E15E1BD4A7F01EBD7BE6CBFE85FDCFF009E5BBAF1FAFA5777A1F89EC7E23697A9E8B2F9BF71248274F91BEF7FF5F915F65887CD459F9ED48F2991E11D7355D7BCE86D65BAFB145FC1FF0002E95D6F867C4FE20934CCDB5AF9D0EF6DAF24';
    wwv_flow_api.g_varchar2_table(29) := '1F31FD2A4D63C4507837C2F0697A0FF7FF007F3BA6D964F6ED535D7C5B9FC36C967BAE97CA41C79F5F2329F32BF21E64BDD3D0FC591E95A05AFEEAEAFE59E5FDE7DFFF0057ED9EF5E51FB475E41AA7C39B29A296587ECB74B6CFE761DFCB0B9C03F5C7E7';
    wwv_flow_api.g_varchar2_table(30) := '4BA8EB53F8CB54FDD4BFB9F9BE4FF9E6A1B827DF1DF9A5F1368B06BDE17BDB2FF459BCA81E4FBE77FC9CE7F4AEAC2C654AA2A923AA07D39FF04E7D1E0D2FE134134B145E74AEDFF7D57D197137FA2FFCBD7FB90217FE55F35FEC17AD41A07C11B29AEBFD';
    wwv_flow_api.g_varchar2_table(31) := 'A91FFDDEA00FAF415D878B3FE0A09E0EF0BDD793F6F97CE8BEFA27DCE3B601E6BCFC551AD88C4CD411FA4E02B51A18787B43D561F167D97F73E55D7FDF0FFE15ADA6F88BED56BFE52B88F00FEDA1E0EF88DA5FFC86746F3FFB893EDB8FC531FD6BA6D37C';
    wwv_flow_api.g_varchar2_table(32) := '6506A83CF8A58A583FCF5AF3EA60EA52F88F730F8AA755735391B8DABFFA543FF4D7EE5682ACF75FF2CBFF001F15CB5C788AC7FD74BFF2CABCEFC4DFB6758F836EA783F75E7EC6937BBEC48D7FBE4F403EB4A9E1653F84DA75A9C23CD23E83D27C37AA9B';
    wwv_flow_api.g_varchar2_table(33) := '5F3FCDB0B4FF007DCB568477D07FA8FED9B0966FF9E1B1D3F2C8AF823C65FF00052AB1B4D52786D75997519A5DDFBF7CA5AC7F444C17C7A923E9CD739E13FF0082835F6BDE28FB14BE2D9668227FF9F5117E00EE3F4AF496495B9798F12A67B439B96E7E';
    wwv_flow_api.g_varchar2_table(34) := '80F892FB9F27CAFEF57CC1FB57788FFE297BD83CAFF8F5AE97C23F1A355BABA87FD3E2D5ACAFFF00D43C7F7ADBD438FEBFE15A7F10BE1DC1E28D066F365FDFCB5E6D372A15A3ED0EFADCB5F0FF00BB67E647C46D020B5D5279BFD6FDEDFF00EEEDEBFAFE';
    wwv_flow_api.g_varchar2_table(35) := '9507C2BD527D2F549BFE597FA2BEC74FF969F30E9F42318FAD777F1DBC33FD83E3CD4F4C97F7B3C5BBEE7DCDA7B7AE2B98F87FA4C1A5EA9650CBFEA25DD1EFFE3DA7B7E9906BEF63579F0FF23F32C651E5A9289D7F807EDDE3CF14FF00C7AFFC7AEDDFBF';
    wwv_flow_api.g_varchar2_table(36) := '67DE2DD781D71CE0D74E61B08EE6E05E416B71379CFF003C8837119E3B572BA95C41F06FC2FE469775F64FB7FF00A4BA6F2CD267B93FA6335761F8DD67A55AC30A41F682B18DEF8CE5BBFEB5F23569D5A8F9A1B1F37567EF6A278B3C470683AF5EC16BA5';
    wwv_flow_api.g_varchar2_table(37) := 'C5A4F94E9B3C8CFDDEBBF71CF507F3AA5E1DD5A73A56B50456B17EF6078DE77C375E720D6E7C66B383C79753DEE836B143AA6C58E7B2B54FDD48A981BFAF1C551F09EA9E15F01DD6B57BE2DFF848FF00B334BD1259120D22082597ED61408227F39C288C';
    wwv_flow_api.g_varchar2_table(38) := 'B3659812C14703278F730928D6F87F13D0A12F7798F44F07EB97DA5FEC1FA5FF00637EF6F6FE76B2FC9CE47B71D6BC82FF00F665FED4D2FCFBFBF962D4FE6911FEF7CC7D6BD17F64FBCF157C5AFD9F7FD16EAC3C3DE12B5BD9BECAEF6497FACEA3216CC8';
    wwv_flow_api.g_varchar2_table(39) := 'F963E45B420FCAA02BB1EB9EF57A1B5F0AFDAAF67F11F88F54B4B2B57F29DEEB51747B9F4091C2101FF808A52A9EC66E117EF5FA23EBB0F4FEB14E329AD2DD59F3B68BF097C47E03D53CF8A5F36089FF00BFF99AFAB3F679F8C93F85AD7C9BA965FDEFF7';
    wwv_flow_api.g_varchar2_table(40) := 'FF00957907C43F8D1F05B4BF3A0B08BC5BF6D8BEFBF9977F7BE8F267F302B99D4752D54780B5AF10F8375ED521FF0084720FB6CF6BAA40258A48F838C90181C74E4E6AF114E75E2A33FC8E9C2D48E1E5EE7E0FFE18FB7F50F1C4F75A5CF3C5E6FDC6F5AF';
    wwv_flow_api.g_varchar2_table(41) := '96BE374DF6BD2E686EAFE2D3A1967F337DD3845DDB78EBD4AF503D4D71537ED0BFB49EA7FB3ECFE2DB5F0E7D93C17B1B7EB765A20DFE58E37E49385CFF001818AEEF4BF85DFD83F0E745F10C516A9E27D6B59B28AE67D5277FB44B2348809C3B9C46A09C';
    wwv_flow_api.g_varchar2_table(42) := '00A00E3BF5AE78E0BD87BD26BB687A33C7FD6FF770835A5F5D3FE09E37E1FF00D9F74AD7B54F3BFE2A3D73FD8B5B295D65F7CE00E7DABD134BF82F63E17FF55E08F11DA7FB6F6BFD0C809AB6BA978FED7C2F35EE8317FA6C53AC696288F717522EEE4E4E';
    wwv_flow_api.g_varchar2_table(43) := '4647B67BF5C0AF4BF83B75F1FBC79A5CF0EB3E0DD2EEF4BFE07BD74B2B8DDED8073F88AEBA951F2F34A5F89E5C70D05539397F0FF3B99DF077E3A687F06FC51653EBDAA5D784E1F3FE44D5ECA782DE4EC537ED29D39FBFDB38AFACEFBF6CAF83B77E17F3';
    wwv_flow_api.g_varchar2_table(44) := 'ED7C79E17BBF2B6EFF00B2DD197CB63D0B617A7BF4CD78BF8E3F653D5754F80DE2787C5175A5FD8A5D2EE249ED76164B6D9117043923952321B02BC67F635FF826CFDABF67DB2F13EB32EA9FDA9E28B24BDFB2A4E628ADA03F3C2081CB395C3124E06EC0';
    wwv_flow_api.g_varchar2_table(45) := '1DCF9BCD82AD173AF7D1DB4EA74CBEBB45FB3A16D75D6FA17FE27783F43F8DDE3CF13F8834BF19587D8AC23FB4CF041A5DC4B2F9013B6FF2C127B60E3A0EF585F00FE09FFC2EEF1459697E1296EB5B9AD5D23BAFB55A8B0FB147B73E7B9F32400038520F';
    wwv_flow_api.g_varchar2_table(46) := '2323839C579BFC7CF8233F837C653C3F6ABF9A0964F2D137BEC930A0E3AF4F4F71F4AFB1BF674F85F7DE0DF85FA2F87B46D522D26F6D7749A8BA385964DEDD403E87824E715E9E3B194E96117B1EA79D94E535B1B8D70C4BF77AD8F03FDB6BF673F18FEC';
    wwv_flow_api.g_varchar2_table(47) := 'FBAF5943E2897C39A84175FF001EB7BA44EF2C5261B942ACAAC854750473D4578B8D6D34CB5B78922E4265FF00759F98B1CD7BCFED210DF683F0E3FB2F59D52EA6F37C4B36F9E77F365DA10EF209C9E4E3A62BC2575418FDF6CFF631D3676AE2CB5FB4A5';
    wwv_flow_api.g_varchar2_table(48) := '7B1E4715E554B2DC6CB0F45DD68FEF47AE697AEC1696B65FD8D2D843E6A796E93B8F364EACC071F201C0E73D2B1FC61A67FC5513D96BDA345770EBD65F23EFF2BF8B0D21E7B8E01FC6A8F8BA4B1BBB5F3A2B5F27ECA8B23CFB0EF933F863F234EB78E0BB';
    wwv_flow_api.g_varchar2_table(49) := 'B583EDF2CBFBA83DFCDDBED9ED57430FECA3CC79BECE5F09F44FFC13CFC370683F0E6F7C252C52CB7BA35EB489BFEE5CD94DF3C128C707A953E8CA735EFDE22FD987FE128B5F3E5D0741BBFEE7DAA00F2C7F438E3F0AA7FF0004EBB5B1D7FE0E594D14BE';
    wwv_flow_api.g_varchar2_table(50) := '4D95AEFB6477F66CE3F5AF75D77C4F05AFFC7AFEF60FEFD7915E5CD59D4E6B1FA664B87E7A11ED63E59D7BF623F0E6A9AA4F3DFF008374196797FD64EE85FF00AF3F8E6B9AFDA3BF67DFF8B4BFF085F8734BF2AF7C79A8DAE8307D96D76F9703B8373707';
    wwv_flow_api.g_varchar2_table(51) := '03858E057259B033B467902BE90F1C7C50B1D06D3CF9658A2FFC7FF4AE7FF675F8853F8F3C513F95612FF664AFF3DEBFFAD93DB3D938C81D29C7192E65EF1E9BCBE31BC62AD73E9CF86BF0E743D2BE08D9784A2D2ED7FB16D74EFECEFB2BA6E8BC8D9B36';
    wwv_flow_api.g_varchar2_table(52) := '11DC15EBEA49AF907E0FFECFB3FECF9AFF00887E1F6BD6175FF08C585D35CF8535BD9BED6E6CA662E2D1DFB4B0B12B8206570735F66785FC59636A3C9FF62B81F8EDAC6ABAA6837B06976B14B0449FF2DD372FF9F4ACE58892BAEE74FD462E51E5E878FE';
    wwv_flow_api.g_varchar2_table(53) := 'A5FB3BC17575E75ADFCB69E6FF00712B7BC23FB3EE956B75FE957F7F77FF004CF7ED5FC863F9D717E19F8F1FF2E57F14BA7CF17F71CECFC2BB2D03E2141F6BFF008FAA8F6FCD1F78D96111D7F883F66FF0E7C46F06EA9E1FBA8AEBFB3354B56B2BA482E9';
    wwv_flow_api.g_varchar2_table(54) := 'E279633F7D378E402320E30704D5ED73E1FC1E17D2FC98A2F2A189163483F82350B8083D8000015ABE0FF8AD636D6BFF002CAAC7893C5D06A96BFF005D7FDBAE6AEBDDF74E3A94F9647CBBF173E06F873C79E3CD17EDFA5C5773C5A8C5227CE53CB6DE39';
    wwv_flow_api.g_varchar2_table(55) := 'E08CF3DBBD70DF13FE0CDF780FE2D7DB7EDF16A3379FF667F2D0A797F36703EB9CD7B278CA3FB2F8F3CF8BF7BF3A7F1FFB42BAAD7BC03FD97E179F5AD66D62FED38A7693EDCFFEA2CA339E71D0B8518C9E9573A9295187CCD3279469D79CBD0F893F6FEF';
    wwv_flow_api.g_varchar2_table(56) := '0CFF0069EA9A2D97FA2CD37FA45EEC7F91B73EC4E07FC05B19AF99E4F87BA9E95733413456BBA39085F9FF0087B76F4AF58FDA17E237FC2DAF8B5AA7886D6D65FB1586DB2D3B7E777971FF001FE27731FF0078573163E2C7BEB612B452E5F9FB95E95075';
    wwv_flow_api.g_varchar2_table(57) := '69525147E67C498C8E331F3AABD3EED0D2F0AE9FFDBDA5CF6516A96B69F6A81E28D1FEE6E1D0FD38AA3E32F107F65E836506A9E5433D840DF6D83CBF9ED97A263D7703B87E06B8DF0BC73DAEA93417FE6C57B17EF51FFD97F7E9DE9DF10358FF00459A6F';
    wwv_flow_api.g_varchar2_table(58) := '36596F767977BE7BEDF33637185F4C703B76AF765FCA7892A9EF7BC7D8DFB0AFC5A834BF80F7B0C52CBE4FF6A4DB11FEFED288467EA39AF48D5FE3A416B69FBA97FD57F72BE26FD99FE22416BA5DEE8B6B2CB0CD75FE91B3FDC5E76FBE0FE95D1FC5AF18';
    wwv_flow_api.g_varchar2_table(59) := '6AB6DE179EF6C3F7D04507DFE7F5AF9AC651946BDBB9FA1641997FB328C7A1EABE28F8B5078A7C67F62F37CEFF009693FF0087D6B77C5DFB586B9F097C0765A5E8DE1C975187CF6927BA49C452FDEF42304E3B12057CFF00FB36E9105D7FA6DD5D79B7BF';
    wwv_flow_api.g_varchar2_table(60) := 'EB27DEE37EEF4C76C74E2BDC7C59E45D5AFF00AD8BCFFE3DFF00E7AD42C3AE7B48F6A39873C798E9AC7F6CCFB2F9F3CB7575E7F91E6246885DF77D3D7F41507C25FDBE3E2DDCF8A27D325F045843A5DD3B469E7EA227BD917FBEE1176A8C73D78F7AF08D';
    wwv_flow_api.g_varchar2_table(61) := '7BE1FDF5D6BDE7C52C5E4449FC79FE40D7B07C1558341D33FD2AEA59BFDBFB9FCB19AD561A9F2BE63586672FB8E9BE23787EFBECBF6D97F753FCDFEE73CF1F8D79DF86FE3CFD97559ECBED5E55EC5FEB13FAD7B2EBDE24B1D52D7F7B2F9D0FFBFF00EAEB';
    wwv_flow_api.g_varchar2_table(62) := 'E55FDA59FC1D6B75E4C52FFC4D2593E44B59C35C6E0BDB6927F3E2B38E1E3262AB8F92F78F7ED07E3C4FFF002CAEBFCFF8D747A5FED053DAEA90412CBFF1F5FC6F5F1C7C319355BAF06EA97B752DD43F60FF0050EE9F348BEFDBDB35EA1F0F7C5D3EBBA5';
    wwv_flow_api.g_varchar2_table(63) := '597DABFD745FC6FF007FEF5615216F74E5963252F78FAB354D7A0BABAB2BDFF5DE53A4927F1F46073B6B33F6DAFDBC3C3975F06F54F08E972DD4DAA6B28B6CF06C317D897782E4E4020E38C719C9ED9AC3F0BEBDFDBDE28B2B28BCDFF59147DF6FDE1D87';
    wwv_flow_api.g_varchar2_table(64) := 'F9CD7C9DFF00052ED1E7D2FF00696F13F95E6DA7DA9D6E53CFCA2DCC6621C83D319CF238C8C75AD68C6EE113CCCD31B530D859CA8C6F7B2BF6B9E55E2CF89D3E83A5CF0452CB77E6E7FDF8AB8CB3F8C33F903F7AF0FF00B253915E6DADF8B27FB54FE6F9';
    wwv_flow_api.g_varchar2_table(65) := 'B0FF009C66BAF1E19F2C622D38DC0EEF3BB6E27FC2BEA63868535CD3EA7E697933D8358F1141A5E836537D97CDFDC2FC9FC5C718FEB54747D2E7F8A16BF6DB5F2BF7527CFBFE4FC0D72D7D713DB6A9FEB7ED7E6BAF97F3FCF1A8E39F6EB5E8B0E9BA1E95';
    wwv_flow_api.g_varchar2_table(66) := 'A5C1F6596287E45F3F665FCCFA8F5CFA57938CAD2A3494A3F15CE794BED163E1F5AC1A5F93AD5D45FF00133B07F2F7C6836FA707BE4122BD5347BAB1BAB5FB14BFBDB2BF4FE7EB5E03E2EF1D7F65E97E4C5E54D07CDF3FF0FD315B1F047E277FC251A5CD';
    wwv_flow_api.g_varchar2_table(67) := 'A64B2FFA6E97B6483F83CC8CFA7FBA7B7A1AF369D2A9562EB1EDE43987B3ABC92EA75BF133F6579FC51A5FFC49AEA5D3B53B5FF533C1394F33D03E31DB8F6C57967C11D7BC63E03F8C90787FC79ACF88ED345BFDD1C174F399608E4FE1CB9CE01C63938C';
    wwv_flow_api.g_varchar2_table(68) := 'E2BEADF83FE26FEDEBB82197FF00B3DD5D5F8F3E1EE95E29B5FF004AB5B59BCDFE09D3E592BA70B8BF75D2ABB3FBD1FA0C70B0C46B1972BFEB731AE3E0A7DAB41BDBDB0F8836B3436AFF003BFEEA558E3DA08CB8EE01E79A975AF853E15F0BE97653DFF8';
    wwv_flow_api.g_varchar2_table(69) := 'F35EBBF36D6693C8B2CCBE6617823C9427BF0091927D8D736DA1E87A0F9104BA5F93F65DDE479175F2479E38CFA8AD5F0C5F58FEE21B0D2ED62822DBF3CF3997CAFC338FCF35518D3EE77C728C43F8AB23C7BC7DF0BFFE1725AFD8BC2F6BE289BE458E7D';
    wwv_flow_api.g_varchar2_table(70) := '46EA6962B78D8A9DC3248DEC091BB683CF19E2BA2F867FB1BE87F04741F3FF007BA8EB575B7CFBA74F9BFDC4F419E78FC6BE88F0FF0091F65FF5BE77FC03E48BE8074AC0F88D75F64FF9E5FBAFDE7F7EB3AD8B76F654B60AD81A54BDEE6E67E6797EBD1C';
    wwv_flow_api.g_varchar2_table(71) := '1A5E830E97FEAA0F9BCFACAF0FEB105ADD7EEBF7DE6FDCFF003ED595E3BD727D5353FF0096B54FC3B6F9BBFDEF95FEC7CF59D3A3CC79B525EF1F537EC8F673EABF16F4C87FDBF35DFE8A4E7E95E1FF00F0588D72C7C51E17D2F53FF97DD2EEA5F9FF008F';
    wwv_flow_api.g_varchar2_table(72) := 'C8B994EC8FE8360603B67DEBD3BF671F157F65FDB6F6297FD36FE0FEC9827FB9E5F99FEBA4FA2461CFD715E49F193E1CC1FB557FC241A64B7F169DE6CF149A74F3A1748D61E234201CE0A6012338EB835B6068F3E357682BBF99E962A11A390D594BE2AA';
    wwv_flow_api.g_varchar2_table(73) := 'D457CB57FE47E7DC9A94175E4432FEF7CAFDE6FAF4ED07C51249A5C45648A318E927DE3EF51FC4CFD92FC63F06EEBEDB7F6B14DA5C5FF2FD6BFE916B229ED91F32FF00C080AC84D763B8B68435AB6628C47C74E2BEBB10E338AB1F917B1953D19D46B175';
    wwv_flow_api.g_varchar2_table(74) := '3E97AA4DF65FF6BEE7DCDBBBBE6B5AF3C69FD97E17B2FF004AFB5CF2FDFD91EC48FD07BD73BE22B3FF0089F4F35D4BFB8F3DBEE7DCFBDFC7ED50DE5E58FF0065FF00ADFB67EFFCC774FB91AF615E3E230F1958F3E7CB19333FC49E269F5EBAFDECB17FC0';
    wwv_flow_api.g_varchar2_table(75) := '13627E5F43E9567E1CEA93DAF8A3CEB5BA8A29A2FF0050FF00CC7B8AE7ECE483FB527F37FDAADEF85FA0C1AF6BDE44B75145F7A481F67F10EDF8D767B2A74A9F2F435A1FCC7D39F057C7505D6BD0CFE6FEFE275F3E0FEA3FCF15F62D9F8360F196830CF1';
    wwv_flow_api.g_varchar2_table(76) := '795FBD4FFBF5F5AFCECD3E7FF845EEBCEB597FD53FC9FC3E663DFD335F5E7C27F8E97DE0DF234BD7A2974F9E5822B9D93E37FCE80838CF7520F3CE31D2BE771987FB513F41C831F295E350DBF177ECD77D7575E7584B145FDFFF00A69ED577C07FB37EAB';
    wwv_flow_api.g_varchar2_table(77) := '6B75FE95145343FEF877AD49BF685D2AD6EBFD6C5FF03C568E95FB4B695756B3F952C5FEFF00DEFE55C6D54E53EC29BA117CC7456FF0FE0D2ED7FEB9578EFC74BEC5D79117FAFF0097674EFD7FCFB559F899FB5FD8E956B37FA57F7B7BFF00057CD7E2EF';
    wwv_flow_api.g_varchar2_table(78) := 'DA03ED7E7EA72CBFEB53F709FF003CF3E83D4FAD6D85C1D494B999E6E618D8F2F2C4EABC596F0697E77EF7FD52797BFF005AF38D43E207DAAEFEC561FF002D76EC4E77C8DD31F9FE95C2EB1F12AFBC65FF004CA1DFF27FD34F6F73FE79AF5BF877F0FF00';
    wwv_flow_api.g_varchar2_table(79) := 'FE157E83FDB5AA45FF0013A951BECB03FF00CB929FE33FF4D0F1D7A74AF52346387A7EF6E78EAA4ABCBDDF84EFBE07F883FE2E8DEF87FCDFDFE8DE1ABDBD7D9F73CF74C13F80E07B7D69BE0F97FB07EDB34BFDC5D95E77FB176AB3EA7FB4B789E697FE5A';
    wwv_flow_api.g_varchar2_table(80) := 'F87AEFFF00AF5D769BE3AD2BFB2E6D2EEAEBEC93CA8BB247FB9BB6F00FA7D6AF2D8DB1153D11F419DEB94E15C7BCFF003457D0FE307D97C513D95D79577657FBADA781FE649233D508F4C57827C5EFD9875CF0A78F6F60D1ECF5DD4F49988B8B39EDA30E';
    wwv_flow_api.g_varchar2_table(81) := '8627E42E7D57EE9FA54BF113C413F837C79FE95FB9F9FF00CFFF005ABDEBE1A7ED0BFD9BE10B687CBB393664665837B0F6CE6BDD74FB1F0F569467A1E19F19FC21AAFF006A4DFD8D6BE74375B639FF00C07E151782FE0CE6D6683CA966F912574FF64F6F';
    wwv_flow_api.g_varchar2_table(82) := 'AD7EC0DC7ECFFF000E6EBFE652D1BFEFC516FF00027E1CE976BFF2296830FF007DF66CFCCF1FA9AFCFE5C435654F9630FC4F2D6475A72B687E296B1F06EFAD6EAF6696C25867F9A4820FE1FBDC8DDECB5D2FC39F82B7D756B04D2C52DA795BBE4E37C99F';
    wwv_flow_api.g_varchar2_table(83) := 'E55FA6BE30F8C1F007C1BE32BDF0FDFE83612DEE97FEBFC8D2DE58A362A0901C75EA327A75C138AE6BE217ED61FB3D7837C073DED8683A5EAD7BFF002C34B82C8DBBEEE803EEC607D339AEC799E3E74E3CB45EA74E1F86AACAA7B39C947D5A491F1EF85F';
    wwv_flow_api.g_varchar2_table(84) := 'C2363FB3EE997BF123C5B17DAECAD5FECDE1ED22EBE6FED6BD1FF2D48C8CDBC27E63D9DB0BC806B1BF679B8D57F682D2FC77AA6B3752CDE21BABD8B5649DFE77915D4A14EBC7206076E2B5FE2D6973FC6EF197FC24FF00106FFEC9F22FF676836BFBA8B4';
    wwv_flow_api.g_varchar2_table(85) := 'E807FAB8C8ED81FC0A07B9ED53FECFFF0017BC2BE17F8C965E18D1AD7CA8359DD6EF3BE3F7926DCC6A3DB70C73ED5EED2C1C961DD49EB3B7DD6E87D0D69D1A30860F0CFF0076B56F6729777E4BA2383F12F8CB5CD06EA6B2965962F2BF76FBFE5FD6B25B';
    wwv_flow_api.g_varchar2_table(86) := 'E276B96B6DFEB62FFBFF005EEFF1BBE16D8EA9AA4F3F95FF002D3CDAF07D73E1EFD97FF8848C7EEEB0C3CA9CBE2444A3554BDD91CCF887E205F6A973FE952CB77F3FC889F7377638EF50E9BA6DF78A354861BA8A59A7FE0B54FBFF00FD6F7CF005751E1F';
    wwv_flow_api.g_varchar2_table(87) := 'F8533DD5D7FCF2FF00D1BFFD6FD7F0AF5FF843F076FAEB5486CB46D2EEAEEF65FB89040F2CB237E009FC4F1F4AEE96262BDDA71338E0AA4FDFA922BFC1DF8410785ED60D4EFE28A5BDFF00961047F3C56DEE33D5FD491C76AF4DD0FE09F88FE3779FF608';
    wwv_flow_api.g_varchar2_table(88) := 'BC9D322FF8FABD9F2B05B7D4F52C7B2282C7DBAD7D17F047FE09E33FD960D53C792CB0FF00D42ED5C79BEC24906447EEAB96F715F402FC14FB5697059456B1693A2DAFFA88204DAB1FD07A9EE4E49EE4D7660F22AD5A5EDB13A47B7F5B1CF8BCE2961E3E';
    wwv_flow_api.g_varchar2_table(89) := 'CF0FACBF0FF827C45E17F853A1FECFBE17F13EA76117EE2D74B9BCFBD9D079B7AC57009FEE264E151781D492726BE2EF8CDA2DF5D68336A96BE6F91E5AC8FF00F4CFF1F4AFB47FE0A75F14F4AF06FC3ABDD174BFDD7F6A5D25927FD348A1F9E47F5C6FC2';
    wwv_flow_api.g_varchar2_table(90) := 'FBD7C19E23FDA0A0F0BDAF91FBA97CDFE07FBBCF5C8AC70B4B9B1356A53F86EA3F72B7F99F4B9ED5FABE5B84C255F8F95C9FACDDD7E162943E2E83E2D7837EC52CBFF134D2D3F70EFF00F2D17FB99F51D4537C17AC5DFF00620DBE6E37B7F1135CD7837C';
    wwv_flow_api.g_varchar2_table(91) := '173EA9AF7F6A45E6E9F652BFC9F27CD27B22FBFAFF003AFA53E1C7FC2A5D27C2D0C3E23B9F1CDBEA4BC98F4EB147B745DA380C5F279CF2403EC2BD1AF5234ACACDFA6A7CD65D83962D3F7B96DDDA5F99FAFD24339FF9758A2FEFECFF00969EF553C410DF';
    wwv_flow_api.g_varchar2_table(92) := '5D6837B05879514D2A3C49D3F799EA8783F78657F1AE82DBC8B5FF005BF6AFF7EAB491CFFF003CA2FD7FC2BF14F6B2EC77616B54A159568F469FDC7E73FED49F0467D075EFED4D07CAD3ACAFDFCB9D274DDF66B91D6323DC74CF1F98AF2EFF0084BB43F0';
    wwv_flow_api.g_varchar2_table(93) := 'BFEFAFEC25BBD4ED7FE5BBD904F2DBD4753F88AFD2FF008DDF05FF00E1636977B3C56B6B777B2A7FA55AA7C89A8C7E83FB922F556FC0FB7E76FED0DF08EFBE1CDD7EEAD7FB5ACA5DDF6579D0EFE3AC120E312AFE19C715F6DC3D9BC6A47D854DFA1F539E';
    wwv_flow_api.g_varchar2_table(94) := '60E9E6345E6D805FF5F23FCAFBAF267837C44F895FF0945D4F3C575FDEFF007FEB5C77C15F0FCFE3DFDA33C17A2C5AA5AE897BACF886C6C93519FF00D5597997089E637B282491919C638CD745E38F00D88FF4D8A2974EF93E7824CFEEFF00C3F1AF32F0';
    wwv_flow_api.g_varchar2_table(95) := '6F88FF00B2FE32787B548BFD468DAA5BDEFF007FFD4CA2423FF1DAFBAC3D28BDCFCD71752A4627EBF7ED1DFB05F8FF00C2FE28D520B0D0754F10D9453BC705D5AC0196E5431C49C31C6E1CE09E338AF1CD27FE09D3F11BC65AA7FA569761A241F2EFFED1';
    wwv_flow_api.g_varchar2_table(96) := 'BA4497F08E3DEE7F10335FA99A2FC66F007C6EF01D9789F4BBAD2F51D3359816E609D24F939FBC87A1C8390C0F420D737AF7C43F0E78374B9AF7ED5A5E93656A8D24F3C9F72351D49E0F4AE75925084B9A4F436A59BE26A72C2943DEF43E50F84FFF0004';
    wwv_flow_api.g_varchar2_table(97) := 'ABD2B41FDFEBD7F7FAB795FBC91204161071C93BDF2F8FC178EE2AAF8FBFE0A05F03FF00638FF892E8DF65BB9E27F2E74D110241B87633B12D37A1E4AFB9EDF307FC150BFE0B097DE3DFB6F82FC07752DA68BF3473CFF765D457FE9A018223CFDD8F3F37';
    wwv_flow_api.g_varchar2_table(98) := '56FEE8FCD6F1078927D7AEA79AEAEA596797F8F7FF009FC8629D38F369858D977B6AFD3FCCF6EB4F0F818FFC28DEA54FE44ED18FF89AD5BF23F723C0FF00F05BCF849FB99F59FB2C5FEC79F26F8D7D3A1C9FC0571FFB507FC16D3C0FAF697FF121D67CEB';
    wwv_flow_api.g_varchar2_table(99) := '2D9FF1E5A7407CDB96F4798E1507AE067DC57E294BA875A4559EEBFD6D12C1E2E51E5957972FA25F8DAE8E78F12E5D092AB4F010E75B5DCDAFB9CACCF6DFDA4FF6B2D57F682F194FAA4BFBAFF96705AA65E2B65F4CF73DC9EE6B94F017847ED5AA79D2C5';
    wwv_flow_api.g_varchar2_table(100) := 'F6B9FF00DBFF00965FD315CD6836FCD7AC7C3BF0CEABAF7FC785AFEE7FE99C7F27E75D34E8D3A30E48688F2F138DAF9857789C4BBB7FD7DDD1791D9F86E4B1D2FF007D2C5F6B9BF1D91FD2B6575D81C67ECB53E8FF00097FB2FC89F59BF8AD3FD8F3FE6F';
    wwv_flow_api.g_varchar2_table(101) := 'C866BB1B1D0B43FB38FDD79DFED7AD73F31DB4E3A1FB3F0D63C73BEE9BE76FCE8A2BF113D1990DDCADF65FBCDE9D6BE46FDB9ECA13A6F8CBF751736105C1F9473209701FFDEC719EB4515D983FE3C7FC48FB2E0ADABFFD7B9FE47C39E33896EEEA512AAC';
    wwv_flow_api.g_varchar2_table(102) := 'A1E121838DC187BE6BC034C8123F1C305445085F6E0636FD28A2BF6AC3F4F99F95E63F023F7C7FE08FDA3DA4BFF04E2F87FBAD6D9BE598F3129EB2B93DBB926B8AFF0082DB429E1EFD8B74F92C116C5EF35F31CED6E3CA33AADBB32AB15C6E01B900F43C';
    wwv_flow_api.g_varchar2_table(103) := 'D14574E6DFEEDF77E675F077FC8D69FABFC8FE7F3C4EE64D46676259F7E771393F9D646A8E7D4F5F5A28ACA86C8F231FFEF33F52A270B5A50A298376067D71CD1456D338A1B9E99F026C20BDD76C84D0C5306EA1D0367F3AFA13C5D2B5869BB20668517A';
    wwv_flow_api.g_varchar2_table(104) := '2C67681F80A28AE0AC7D0503CEF4FBA96E2EE49649247957A3B312C3F1AF56D1CE2C568A2B0AA752D8FFD9';
 
end;
/

begin
wwv_flow_ws_import_api.create_file(
  p_id => 39350971263632543125482572077858785141+wwv_flow_api.g_id_offset,
  p_ws_app_id => wwv_flow.g_ws_app_id,
  p_webpage_id => 123624015010323160+wwv_flow_api.g_id_offset,
  p_component_level => 'WEBPAGE',
  p_name => 'martin.jpg',
  p_varchar2_table=> wwv_flow_api.g_varchar2_table,
  p_content_last_update =>to_date('20150818130229','YYYYMMDDHH24MISS'),
  p_mime_type => 'image/jpeg',
  p_content_filename => 'martin.jpg',
  p_image_alias => 'martin.jpg'
  );
 
end;
/

begin
--application/end_environment
commit;
end;
/

begin
execute immediate 'begin sys.dbms_session.set_nls( param => ''NLS_NUMERIC_CHARACTERS'', value => '''''''' || replace(wwv_flow_api.g_nls_numeric_chars,'''''''','''''''''''') || ''''''''); end;';
end;
/

set verify on
set feedback on
prompt  ...done
