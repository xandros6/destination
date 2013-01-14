<div id="main" class="links">
    <a href="http://84.33.2.23/MapStore" target="_blank"><img src="http://84.33.2.23/MapStore/theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">Attribute</th><th class="title">Value</th>

  </tr>

<#assign odd = false>
    <#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
         <#if odd>
         <tr class="odd">
         <#else>
                <tr>
                </#if>
                
                
                <#assign odd = !odd>
                    <#if attribute.name == 'value'>
                        <#assign val=attribute.value>
                    </#if>                    
                </tr>
        </#if>
    </#list>
    <th>Valore</th><td>${(val?number)?int}</td>
    </tr>

</table>
<hr />
</#list>
<br/>
