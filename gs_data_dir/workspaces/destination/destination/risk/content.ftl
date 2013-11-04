<div id="main" class="links">
    <a href="http://destination.geo-solutions.it/MapStore" target="_blank"><img src="http://destination.geo-solutions.it/MapStore/theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign mixed = false/>

<#list request.ENV?keys as key>
  <#if key == 'LOWSOCIALE'>
    <#assign mixed = true/>
  </#if>
</#list>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>


<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attribute","Attribute","Attribut"][locale]}</th><th class="title">${["Value","Value","Value","Wert"][locale]}</th>

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
                    <#if attribute.name == 'rischio1'>
                        <#assign rischio1=attribute.value>
                    </#if>
                    <#if attribute.name == 'rischio2'>
                        <#assign rischio2=attribute.value>
                    </#if>
					                              
                </tr>
        </#if>
    </#list>
    <#if mixed>
    <th>${["Processed Value - Social","Valore Elaborazione - Sociale","Valore Elaborazione - Sociale","Valore Elaborazione - Sociale"][locale]}</th><td>${rischio1?number}</td>
    </tr><tr>
    <th>${["Processed Value - Environmental","Valore Elaborazione - Ambientale","Valore Elaborazione - Ambientale","Valore Elaborazione - Ambientale"][locale]}</th><td>${rischio2?number}</td>
    <#else>
    <th>${["Processed Value","Valore Elaborazione","Valore Elaborazione","Valore Elaborazione"][locale]}</th><td>${rischio1?number}</td>
	</#if>
    </tr>
</table>
<hr />
</#list>
<br/>
