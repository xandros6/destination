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
					<#if attribute.name == 'nat_code'>
						<th>${["NAT Code","NAT Code","NAT Code","Gemeindekodex"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'pres_max'>
						<th>${["Max Presence","Presenza massima","Presenza massima","maximale Nächtigungen"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'pres_med'>
						<th>${["Mean Presence","Presenza media","Presenza media","mittlere Nächtigungen"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'denominazione_comune_' + request.ENV.LOCALE>
						<th>${["Municipality","Comune","Comune","Gemeinde"][locale]}</th><td>${attribute.value}</td> 
                    </#if>   
					<#if attribute.name == 'partner_' + request.ENV.LOCALE>
						<th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                    </#if>					
                </tr>
        </#if>
    </#list>
	<th>${["Type","Tipologia","Tipologia","Tipologia"][locale]}</th><td>${["Tourist People","Popolazione turistica","Popolazione turistica","Popolazione turistica"][locale]}</td> 
    </tr>

</table>
<hr />
</#list>
<br/>
