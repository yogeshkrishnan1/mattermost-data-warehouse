with events_deduped as (
    select
        {{ dbt_utils.star(from=source('rudder_support', 'base_events')) }}
    from
        {{ source('rudder_support', 'base_events') }} b
    where
        not exists (select 1 from {{ ref('base_events_delta') }} d where d.id = b.id)

    union all

    -- Note that base_events_delta is already deduped. This helps avoid re-deduping the same data every time the view is
    -- called.
    select
        {{ dbt_utils.star(from=ref('base_events_delta')) }}
    from
        {{ ref('base_events_delta') }}
),
renamed as (

    select

        -- Common event columns
        id               as event_id
        , event          as event_table
        , event_text     as event_name
        , category
        , type          as event_type
        , user_id        as server_id
        , user_actual_id as user_id
        , received_at    as received_at
        , timestamp      as timestamp


        -- Event properties
        , priority
        , __proto_node_options
        , __proto_shell
        , _from
        , _view
        , _where
        , after
        , anonymous_id
        , app
        , app_id
        , banner
        , board
        , board_template_id
        , boards
        , caller_info
        , card
        , card_template_id
        , catggory
        , channel
        , channel_id
        , channel_ids
        , channel_ids_0
        , channel_ids_1
        , channel_ids_2
        , channel_len
        , channel_sidebar
        , channels
        , channels_ids
        , channelsids
        , checksum
        , context
        , context_app_build
        , context_app_name
        , context_app_namespace
        , context_app_namgspace
        , context_app_proto_node_options
        , context_app_proto_shell
        , context_app_version
        , context_app_where
        , context_campaign
        , context_campaign_adgroup
        , context_campaign_adgroupid
        , context_campaign_campaignid
        , context_campaign_channel
        , context_campaign_content
        , context_campaign_contentewd
        , context_campaign_creative
        , context_campaign_device
        , context_campaign_expid
        , context_campaign_id
        , context_campaign_keyword
        , context_campaign_loc_physical_ms
        , context_campaign_matchtype
        , context_campaign_medium
        , context_campaign_name
        , context_campaign_network
        , context_campaign_nooverride
        , context_campaign_params
        , context_campaign_placement
        , context_campaign_proto_node_options
        , context_campaign_proto_shell
        , context_campaign_referrer
        , context_campaign_source
        , context_campaign_source_utm_campaign
        , context_campaign_sources
        , context_campaign_sq
        , context_campaign_targetid
        , context_campaign_term
        , context_campaign_type
        , context_campaign_where
        , context_compiled
        , context_contains
        , context_destination_id
        , context_destination_type
        , context_ip
        , context_library_name
        , context_library_proto_node_options
        , context_library_proto_shell
        , context_library_version
        , context_library_where
        , context_locale
        , context_os_name
        , context_os_proto_node_options
        , context_os_proto_shell
        , context_os_version
        , context_os_where
        , context_page_4
        , context_page_5
        , context_page_initial_referrer
        , context_page_initial_referring_domain
        , context_page_path
        , context_page_proto_node_options
        , context_page_proto_shell
        , context_page_referrer
        , context_page_referring_domain
        , context_page_search
        , context_page_tab_url
        , context_page_title
        , context_page_url
        , context_page_where
        , context_passed_ip
        , context_proto_node_options
        , context_proto_shell
        , context_relevance
        , context_request_ip
        , context_screen_density
        , context_screen_height
        , context_screen_inner_height
        , context_screen_inner_width
        , context_screen_proto_argv_0
        , context_screen_proto_node_options
        , context_screen_proto_shell
        , context_screen_where
        , context_screen_width
        , context_scregn_density
        , context_session_id
        , context_session_start
        , context_source_id
        , context_source_type
        , context_terminators_lastindex
        , context_timezone
        , context_traits_active_address_id
        , context_traits_address
        , context_traits_auth_provider
        , context_traits_cellphone
        , context_traits_city
        , context_traits_date_of_birth
        , context_traits_district
        , context_traits_edition
        , context_traits_email
        , context_traits_event_tenant
        , context_traits_firstname
        , context_traits_id
        , context_traits_identity
        , context_traits_instance_id
        , context_traits_item_in_cart
        , context_traits_language
        , context_traits_last_audience_visit
        , context_traits_lastname
        , context_traits_latitude
        , context_traits_longitude
        , context_traits_name
        , context_traits_nb_of_audience_visit
        , context_traits_order_id
        , context_traits_org_id
        , context_traits_phone
        , context_traits_phone_number
        , context_traits_portal_customer_id
        , context_traits_proto_node_options
        , context_traits_province
        , context_traits_referrer
        , context_traits_session_id
        , context_traits_shipping_method_kind
        , context_traits_subdistrict
        , context_traits_tenant
        , context_traits_use_oauth
        , context_traits_user_id
        , context_traits_version
        , context_traits_version_cli
        , context_traits_where
        , context_user_agent
        , context_user_agent_data_brands
        , context_user_agent_data_mobile
        , context_user_agent_data_platform
        , context_useragent
        , context_where
        , count
        , cta
        , customized_name
        , customized_visibility
        , download
        , duration
        , email
        , error
        , errors
        , field
        , filter
        , first
        , first_effectiveness
        , first_recomputations
        , fresh
        , from_page
        , gfyid
        , github
        , gitlab
        , group_constrained
        , inapp_notice
        , include_deleted
        , inquiry
        , inquiry_issue
        , installed_version
        , invite_count
        , is_first_preload
        , jira
        , join_call
        , keyword
        , license_id
        , longest_api_resource
        , longest_api_resource_duration
        , max_api_resource_size
        , method
        , metric
        , mkt_tok
        , my_auth
        , name
        , num_high
        , num_invitations
        , num_invitations_sent
        , num_low
        , num_medium
        , num_of_request
        , num_total
        , org_id
        , original_timestamp
        , persistent_notifications
        , playbooks
        , plugin_id
        , post_id
        , privacy
        , q
        , qk
        , qp
        , qw
        , qx
        , redirect_source
        , remaining
        , request_count
        , requested_ack
        , role
        , root_id
        , scheme_id
        , screen
        , seats
        , second
        , second_effectiveness
        , second_recomputations
        , section
        , sent_at
        , servicenow
        , sid
        , sort
        , sort_by
        , source
        , src
        , started_by_role
        , success
        , team_id
        , template
        , tf_anonymous_requester_email
        , tf_description
        , tf_subject
        , third
        , third_effectiveness
        , third_recomputations
        , ticket_form_id
        , todo
        , total_duration
        , total_size
        , type_location
        , typeform_source
        , u
        , uid
        , url
        , user_actual_role
        , userid
        , users
        , utm_campaign
        , utm_content
        , utm_id
        , utm_medium
        , utm_source
        , uuid_ts
        , uype
        , value
        , version
        , view_type
        , warn_metric_id
        , warnmetricid
        , zoom

    from events_deduped

)

select * from renamed
