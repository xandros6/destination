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
					<#if attribute.name == 'nr_incidenti'>
						<th>${["N. Incidenti","N. Incidenti","N. Incidenti","N. Incidenti"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'nr_corsie'>
						<th>${["N. Corsie","N. Corsie","N. Corsie","N. Corsie"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'lunghezza'>
						<th>${["Lunghezza","Lunghezza","Lunghezza","Lunghezza"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
									
                </tr>
        </#if>
    </#list>
	
    </tr>

</table>
<hr />
</#list>
<br/>
