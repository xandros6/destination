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
					<#if attribute.name == 'cod_fisc'>
						<th>${["Fiscal Code","Codice Fiscale","Codice Fiscale","Mehrwertssteuer-Nummer"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'descrizione_ateco_' + request.ENV.LOCALE>
						<th>${["ATECO Description","Descrizione ATECO","Descrizione ATECO","Beschreibung des ATECO Kodex"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'addetti'>
						<th>${["Employees Number","N. Addetti","N. Addetti","Anzahl der Beschäftigten"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'fonte_addetti_' + request.ENV.LOCALE>
						<th>${["Employees number source (Estimated / calculated)", "Fonte addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Anzahl der Beschäftigten (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'partner_' + request.ENV.LOCALE>
						<th>${["Partner","Partner","Partner","Partner"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
                </tr>
        </#if>
    </#list>
	<th>${["Type","Tipologia","Tipologia","Tipologia"][locale]}</th><td>${["Industry and Services Users/Employees","Utenti/Addetti industria e servizi","Utenti/Addetti industria e servizi","Utenti/Addetti industria e servizi"][locale]}</td> 
    </tr>

</table>
<hr />
</#list>
<br/>
