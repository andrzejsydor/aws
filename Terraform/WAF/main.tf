resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = [aws_waf_xss_match_set.xss_match_set, aws_waf_rule.wafrule]
  name        = "xss_WebACL_tf"
  metric_name = "xssWebACLtf"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = aws_waf_rule.wafrule.id
    type     = "REGULAR"
  }
}

resource "aws_waf_rule_group" "xss_rule_group_tf" {
  name        = "xss_rule_group_tf"
  metric_name = "xssrulegrouptf"

  activated_rule {
    action {
      type = "COUNT"
    }

    priority = 50
    rule_id  = aws_waf_rule.wafrule.id
  }
}

resource "aws_waf_xss_match_set" "xss_match_set" {
  name = "xss_match_set"

  xss_match_tuples {
    text_transformation = "NONE"

    field_to_match {
      type = "URI"
    }
  }

  xss_match_tuples {
    text_transformation = "NONE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = [aws_waf_xss_match_set.xss_match_set]
  name        = "WAFRule_tf"
  metric_name = "WAFRuletf"

  predicates {
    data_id = aws_waf_xss_match_set.xss_match_set.id
    negated = false
    type    = "XssMatch"
  }
}
