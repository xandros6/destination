<div id="main" class="links">
    <a href="http://destination.geo-solutions.it/MapStore" target="_blank"><img src="http://destination.geo-solutions.it/MapStore/theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

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
                    <#if attribute.name == 'rischio_sociale'>
                        <#assign sociale=attribute.value>
                    </#if>
					<#if attribute.name == 'rischio_ambientale'>
                        <#assign ambientale=attribute.value>
                    </#if>
                    <#if attribute.name == 'lunghezza'>
                        <#assign length=attribute.value>
                    </#if>                                 
                </tr>
        </#if>
    </#list>
    <th>${["Social Risk","Rischio Sociale","Rischio Sociale","Rischio Sociale"][locale]}</th><td>${sociale}</td>
	</tr>
	<tr>
	<th>${["Environmental Risk","Rischio Ambientale","Rischio Ambientale","Rischio Ambientale"][locale]}</th><td>${ambientale}</td>
    </tr>

</table>
<hr />
</#list>
<br/>
