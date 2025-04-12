domain_parts = _url.split("://");
real_domain = domain_parts[1].split("/");
domain = real_domain[0];
domainText.text = "Domain is: " + domain;
