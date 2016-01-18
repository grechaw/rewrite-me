xquery version "1.0-ml";

(: Copyright 2002-2015 MarkLogic Corporation.  All Rights Reserved. :)


let $mod-db := if (xdmp:modules-database() eq 0) then "none" else xdmp:database-name(xdmp:modules-database())
let $data-node :=
    object-node {
    "message":"Here is yup",
    "database" : xdmp:database-name(xdmp:database()),
    "modulesDatabse" : $mod-db,
    "modules-root" : xdmp:modules-root(),
    "collation" : fn:default-collation(),
    "xqversion" : xdmp:xquery-version()
    }
let $data := xdmp:from-json($data-node)
let $links := (
"", 
"?modules-root=XXXXXXX",
"?modules-root=XXXXXXX&amp;database=App-Services",
"?modules-root=/&amp;modules-database=Modules",
"?modules-root=XXXXXXX/new-root",
"?modules-root=/new-root&amp;modules-database=Modules",
"?modules-root=/new-root&amp;modules-database=Modules&amp;defaultxquery=0.9-ml",
"?modules-root=XXXXXXX&amp;collationURI=http://marklogic.com/collation/codepoints/"
)
return
(
xdmp:set-response-content-type("text/html"),
<html>
<ol>
{
for $l in $links
return
<li><a href="http://localhost:9999/{$l}">link to: {$l}</a></li>
}
</ol>
<dl>
{
for $key in map:keys($data)
return 
(<dt>{$key}</dt>,
<dl>{map:get($data, $key)}</dl>)
}
</dl>
</html>
)
