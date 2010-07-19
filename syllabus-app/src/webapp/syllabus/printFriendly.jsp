<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<%@ taglib uri="http://sakaiproject.org/jsf/syllabus" prefix="syllabus" %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<f:view>

<script type="text/javascript">
	// SAK-12177: If i'm being loaded into the iframe upon redirect
	// reset the tool so proper page will be displayed
	// NOTE: URL taken from reset icon 
	if (window.parent.location.href.indexOf("printFriendly") == -1)
	    window.location.href = '<h:outputText value="#{SyllabusTool.resetUrl}" />';
</script>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.syllabus.bundle.Messages"/>
</jsp:useBean>

	<sakai:view_container title="#{msgs.title_list}">
	<sakai:view_content>

<%-- gsilver: global things about syllabus tool:
1 ) what happens to empty lists - still generate a table?
2 ) Ids generated by jsf start with _  not optimal keeps us from validating fully.
 --%>
	<h:form>
		 	<div>
				<a id="printIcon" href="" onClick="javascript:window.print();">
					<h:graphicImage url="/images/printer.png" alt="#{msgs.print_friendly}" title="#{msgs.print_friendly}" />
					<h:outputText value="#{msgs.send_to_printer}" />
				</a>
				<h:outputText value=" " /><h:outputText value="|" /><h:outputText value=" " />
				<a value="" href="" onClick="window.close();" >
					<h:outputText value="#{msgs.close_window}" />
				</a>
			</div>
			
			<syllabus:syllabus_if test="#{SyllabusTool.syllabusItem.redirectURL}">
				<h:dataTable value="#{SyllabusTool.entries}" var="eachEntry" rendered="#{! SyllabusTool.syllabusItem.redirectURL}" style="margin-top:1em;clear:both;" summary="#{msgs.mainCaption}" >
					<h:column>
							<f:verbatim><h4 class="textPanelHeader"></f:verbatim>		  
								<h:outputText value="#{eachEntry.entry.title}" />
								<h:outputText rendered="#{eachEntry.status == 'draft'}" value="#{msgs.mainDraft}"/>
							<f:verbatim></h4></f:verbatim>
							<f:verbatim><div class="textPanel"></f:verbatim>
							<syllabus:syllabus_htmlShowArea value="#{eachEntry.entry.asset}" />
							<f:verbatim></div></f:verbatim>
							<h:dataTable value="#{eachEntry.attachmentList}" var="eachAttach" styleClass="indnt1" summary="layout">
							  <h:column>
									<f:facet name="header">
										<h:outputText value="" />
									</f:facet>
									<sakai:contentTypeMap fileType="#{eachAttach.type}" mapType="image" var="imagePath" pathPrefix="/library/image/"/>									
									<h:graphicImage id="exampleFileIcon" value="#{imagePath}" />
									<h:outputLink value="#{eachAttach.url}" target="_blank" title="#{msgs.openLinkNewWindow}">
										<h:outputText value=" "/><h:outputText value="#{eachAttach.name}"/>
									</h:outputLink>
								</h:column>
							</h:dataTable>
					</h:column>
				</h:dataTable>
				<h:outputText value="#{msgs.syllabus_noEntry}" styleClass="instruction" rendered="#{SyllabusTool.displayNoEntryMsg}"/>
			</syllabus:syllabus_if>				
			<syllabus:syllabus_ifnot test="#{SyllabusTool.syllabusItem.redirectURL}">
  			<syllabus:syllabus_iframe redirectUrl="#{SyllabusTool.syllabusItem.redirectURL}" width="960px" height="1142px"/>
			</syllabus:syllabus_ifnot>
		</h:form>
	</sakai:view_content>
	</sakai:view_container>
</f:view>
