
data "akamai_property_rules_builder" "incl2prop_rule_default" {
  rules_v2023_01_05 {
    name      = "default"
    is_secure = false
    comments  = ""
    behavior {
    }
    children = [
      data.akamai_property_rules_builder.incl2prop_rule_offload_origin.json,
      data.akamai_property_rules_builder.incl2prop_rule_accelerate_delivery.json,
      data.akamai_property_rules_builder.incl2prop_rule_minimize_payload.json,
      data.akamai_property_rules_builder.incl2prop_rule_redirect_to_https.json,
      data.akamai_property_rules_builder.incl2prop_rule_augment_insights.json,
    ]
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_offload_origin" {
  rules_v2023_01_05 {
    name                  = "Offload origin"
    is_secure             = false
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.incl2prop_rule_cache_settings.json,
      data.akamai_property_rules_builder.incl2prop_rule_uncachable_objects.json,
    ]
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_accelerate_delivery" {
  rules_v2023_01_05 {
    name                  = "Accelerate Delivery"
    is_secure             = false
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.incl2prop_rule_origin_connectivity.json,
      data.akamai_property_rules_builder.incl2prop_rule_protocol_optimizations.json,
    ]
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_minimize_payload" {
  rules_v2023_01_05 {
    name                  = "Minimize payload"
    is_secure             = false
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.incl2prop_rule_compress_objects.json,
    ]
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_redirect_to_https" {
  rules_v2023_01_05 {
    name                  = "Redirect to HTTPS"
    is_secure             = false
    comments              = "Redirect to the same URL on HTTPS protocol, issuing a 301 response code (Moved Permanently). You may change the response code to 302 if needed."
    criteria_must_satisfy = "all"
    criterion {
      request_protocol {
        value = "HTTP"
      }
    }
    behavior {
      redirect {
        destination_hostname  = "SAME_AS_REQUEST"
        destination_path      = "SAME_AS_REQUEST"
        destination_protocol  = "HTTPS"
        mobile_default_choice = "DEFAULT"
        query_string          = "APPEND"
        response_code         = 301
      }
    }
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_augment_insights" {
  rules_v2023_01_05 {
    name                  = "Augment insights"
    is_secure             = false
    comments              = "Control the settings related to monitoring and reporting. This gives you additional visibility into your traffic and audiences."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.incl2prop_rule_geolocation.json,
    ]
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_cache_settings" {
  rules_v2023_01_05 {
    name                  = "Cache settings"
    is_secure             = false
    criteria_must_satisfy = "all"
    behavior {
      caching {
        behavior                 = "CACHE_CONTROL"
        cache_control_directives = ""
        cacheability_settings    = ""
        default_ttl              = "0s"
        enhanced_rfc_support     = true
        expiration_settings      = ""
        honor_max_age            = true
        honor_must_revalidate    = false
        honor_no_cache           = true
        honor_no_store           = true
        honor_private            = false
        honor_proxy_revalidate   = false
        honor_s_maxage           = true
        must_revalidate          = false
        revalidation_settings    = ""
      }
    }
    behavior {
      downstream_cache {
        allow_behavior = "REMAINING_LIFETIME"
        behavior       = "ALLOW"
        send_headers   = "CACHE_CONTROL_AND_EXPIRES"
        send_private   = false
      }
    }
    behavior {
      prefresh_cache {
        enabled     = true
        prefreshval = 90
      }
    }
    behavior {
      cp_code {
        value {
          created_date = 1449856654000
          description  = "www.test-cloudlet.com"
          id           = 433934
          name         = "www.test-cloudlet.com"
          products     = ["Fresca", ]
        }
      }
    }
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_uncachable_objects" {
  rules_v2023_01_05 {
    name                  = "Uncachable objects"
    is_secure             = false
    criteria_must_satisfy = "all"
    criterion {
      cacheability {
        match_operator = "IS_NOT"
        value          = "CACHEABLE"
      }
    }
    behavior {
      downstream_cache {
        behavior = "BUST"
      }
    }
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_origin_connectivity" {
  rules_v2023_01_05 {
    name                  = "Origin Connectivity"
    is_secure             = false
    criteria_must_satisfy = "all"
    behavior {
      dns_async_refresh {
        enabled = true
        timeout = "1h"
      }
    }
    behavior {
      timeout {
        value = "5s"
      }
    }
    behavior {
      read_timeout {
        value = "120s"
      }
    }
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_protocol_optimizations" {
  rules_v2023_01_05 {
    name                  = "Protocol Optimizations"
    is_secure             = false
    criteria_must_satisfy = "all"
    behavior {
      brotli {
        enabled = true
      }
    }
    behavior {
      allow_transfer_encoding {
        enabled = true
      }
    }
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_compress_objects" {
  rules_v2023_01_05 {
    name                  = "Compress objects"
    is_secure             = false
    criteria_must_satisfy = "all"
    criterion {
      content_type {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        match_wildcard       = true
        values               = ["application/*javascript*", "application/*json*", "application/*xml*", "application/text*", "application/vnd-ms-fontobject", "application/vnd.microsoft.icon", "application/x-font-opentype", "application/x-font-truetype", "application/x-font-ttf", "application/xmlfont/eot", "font/eot", "font/opentype", "font/otf", "image/svg+xml", "image/vnd.microsoft.icon", "image/x-icon", "text/*", "application/octet-stream*", "application/x-font-eot*", "font/ttf", "application/font-ttf", "application/font-sfnt", "application/x-tgif", ]
      }
    }
    behavior {
      gzip_response {
        behavior = "ORIGIN_RESPONSE"
      }
    }
  }
}

data "akamai_property_rules_builder" "incl2prop_rule_geolocation" {
  rules_v2023_01_05 {
    name                  = "Geolocation"
    is_secure             = false
    comments              = "Receive data about a user's geolocation and connection speed in a request header. If you change cached content based on the values of the X-Akamai-Edgescape request header, contact your account representative."
    criteria_must_satisfy = "all"
    criterion {
      request_type {
        match_operator = "IS"
        value          = "CLIENT_REQ"
      }
    }
    behavior {
      edge_scape {
        enabled = true
      }
    }
  }
}
