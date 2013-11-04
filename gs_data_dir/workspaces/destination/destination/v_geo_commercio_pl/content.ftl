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
					<#if attribute.name == 'insegna_' + request.ENV.LOCALE>
						<th>${["Signboard","Insegna","Insegna","Firmenbezeichnung"][locale]}</th><td>${attribute.value}</td> 
                    </#if>                                                             
					<#if attribute.name == 'sup_vendita'>
						<th>${["Sale Area","Sup. di vendita","Sup. di vendita","Verkaufsfläche"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'fonte_utenti_' + request.ENV.LOCALE>
						<th>${["Customers number source (Estimated / calculated)", "Fonte utenti", "Source du nombre de clients (Estimé/calculé)", "Quelle der Anzahl der Kunden (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'utenti'>
						<th>${["Customers number", "N. Utenti", "Nombre de clients", "Anzahl der Kunden"][locale]}</th><td>${attribute.value}</td> 
                    </#if>	
					<#if attribute.name == 'fonte_addetti_commercio_' + request.ENV.LOCALE>
						<th>${["Employees number source (Estimated / calculated)", "Fonte Addetti", "Source du nombre d'employés (Estimé/calculé)", "Quelle der Anzahl der Beschäftigten (geschätzt/berechnet)"][locale]}</th><td>${attribute.value}</td> 
                    </#if>
					<#if attribute.name == 'addetti'>
						<th>${["Employees number", "N. Addetti", "Nombre d'employés", "Anzahl der Beschäftigten"][locale]}</th><td>${attribute.value}</td> 
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
