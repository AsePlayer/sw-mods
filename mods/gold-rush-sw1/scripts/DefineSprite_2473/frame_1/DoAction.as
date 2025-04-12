domain_parts = _url.split("://");
real_domain = domain_parts[1].split("/");
domain = real_domain[0];
if(domain == "www.stickpage.com" && domain == "farm.stickpage.com")
{
     gotoAndStop(2);
}
stop();
