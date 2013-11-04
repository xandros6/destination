<div id="main" class="links">
    <a href="http://destination.geo-solutions.it/MapStore" target="_blank"><img src="http://destination.geo-solutions.it/MapStore/theme/app/img/BannerDestination_ftl.jpg" width="230" height="83" Hspace="10" Vspace="5"/></a>
</div>

<#assign locale = {"en":0,"it":1,"fr":2,"de":3}[request.ENV.LOCALE]/>

<#list features as feature>
<table class="featureInfo">
  <tr>

    <th class="title">${["Attribute","Attribute","Attribute","Attribut"][locale]}</th><th class="title">${["Value","Value","Value","Wert"][locale]}</th>
	
  </tr>
    <#assign type='ambientali'>
	<#list feature.attributes as attribute>
        <#if !attribute.isGeometry>
			<#if attribute.name == 'distance2' || attribute.name == 'distance3' || attribute.name == 'distance4'>
				<#assign type='sociali'>
			</#if>
		</#if>
	</#list>
  
	<#if type == 'ambientali'>
		<tr><th>${["Radius","Raggio","Raggio","Raggio"][locale]}</th><td>${(feature.distance1.value?number)?int}</td></tr>
	</#if>
	<#if type == 'sociali'>
		
		<#if feature.distance1.value?number != 0>
			<tr><th>${["High letality","Elevata letalità","Elevata letalità","Elevata letalità"][locale]}</th><td>${(feature.distance1.value?number)?int}</td></tr>
		</#if>
		<#if feature.distance2.value?number != 0>
			<tr><th>${["Start letality","Inizio letalità","Inizio letalità","Inizio letalità"][locale]}</th><td>${(feature.distance2.value?number)?int}</td></tr>
		</#if>
		<#if feature.distance3.value?number != 0>
			<tr><th>${["Irreversible Damage","Danni irreversibili","Danni irreversibili","Danni irreversibili"][locale]}</th><td>${(feature.distance3.value?number)?int}</td></tr>
		</#if>
		<#if feature.distance4.value?number != 0>
			<tr><th>${["Reversible Damage","Danni reversibili","Danni reversibili","Danni reversibili"][locale]}</th><td>${(feature.distance4.value?number)?int}</td></tr>
		</#if>
		
	</#if>
  

</table>
<hr />
</#list>
<br/>
