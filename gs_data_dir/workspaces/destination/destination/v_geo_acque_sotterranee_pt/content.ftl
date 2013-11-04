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
					<#if attribute.name == 'denominazione_' + request.ENV.LOCALE>
						<th>${["Name","Denominazione","Denominazione","Benennung"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'toponimo_completo_' + request.ENV.LOCALE>
						<th>${["Full Toponym","Toponimo completo","Toponimo completo","Toponimo completo"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					                                                          
					<#if attribute.name == 'codice_clc'>
						<th>${["CLC Code","Codice CLC","Codice CLC","Codice CLC"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'descrizione_clc_' + request.ENV.LOCALE>
						<th>${["CLC Description","Descrizione CLC","Descrizione CLC","Descrizione CLC"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'tipo_captazione_' + request.ENV.LOCALE>
						<th>${["Captation Type","Tipo captazione","Tipo captazione","Fassungstyp"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					
					<#if attribute.name == 'superficie'>
						<th>${["Area","Superficie","Superficie","Fläche"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'partner_' + request.ENV.LOCALE>
						<th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
				
					
                </tr>
        </#if>
    </#list>
    </tr>

</table>
<hr />
</#list>
<br/>
