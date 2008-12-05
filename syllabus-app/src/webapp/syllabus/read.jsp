<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<%@ taglib uri="http://sakaiproject.org/jsf/syllabus" prefix="syllabus" %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<f:view>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.syllabus.bundle.Messages"/>
</jsp:useBean>

	<sakai:view_container title="#{msgs.title_edit}">
		<sakai:view_content>
			<h:form>
		  	<sakai:tool_bar_message value="#{msgs.editNotice}" /> 
				<sakai:doc_section>
					<h:outputText value="#{msgs.newSyllabusForm1}"/>
					<h:outputText value="*" styleClass="reqStarInline"/>
					<h:outputText value="#{msgs.newSyllabusForm2}"/>
				</sakai:doc_section>

			<h:panelGrid columns="1" styleClass="jsfFormTable" summary="layout">
				<h:panelGroup styleClass="shorttext required">
					<h:outputText value="*" styleClass="reqStar"/>
					<h:outputLabel for="title">
						<h:outputText value="#{msgs.syllabus_title}"/>
					</h:outputLabel>
					<h:inputText value="#{SyllabusTool.entry.entry.title}" id="title"/>
					<h:outputText value="#{msgs.empty_title_validate}" styleClass="alertMessage" 
									rendered="#{SyllabusTool.displayTitleErroMsg}"/>
				</h:panelGroup>
			</h:panelGrid>

			<p class="longtext">
				<label for=""> <%-- outputLabel needed here instead but there is no target to id --%>
					<h:outputText value="#{msgs.syllabus_content}"/>
				</label>		
				<sakai:rich_text_area value="#{SyllabusTool.entry.entry.asset}"   rows="17" columns="70"/>
			</p>	
			<div class="checkbox">
				<h:selectOneRadio value="#{SyllabusTool.entry.entry.view}"  layout="pageDirection" title="#{msgs.publicPrivate}">
					<f:selectItem itemValue="no" itemLabel="#{msgs.noPrivate}"/>
					<f:selectItem itemValue="yes" itemLabel="#{msgs.yesPublic}"/>
				</h:selectOneRadio>
			</div>
			<h4>
				<h:outputText value="#{msgs.attachment}"/>
			</h4>	
<%--						<h:outputText value="#{msgs.attachment}"/>
						<h:outputText value=" "/>--%>

<%--							<h:commandLink action="#{SyllabusTool.processAddAttWithOldItem}" onfocus="document.forms[0].onsubmit();">
									<h:outputText value="#{msgs.attachment_local} "/>
							</h:commandLink>--%>
<%--							<h:outputText value=" "/>
							<h:outputLink value="sakai.filepicker.helper/tool" onfocus="document.forms[0].onsubmit(); document.forms[0].submit();return false;">
							  <h:outputText id="file_picker" value=" #{msgs.file_picker}"/>
							</h:outputLink>--%>
					
					<sakai:button_bar>
<%-- (gsilver) cannot pass a needed title atribute to this next item --%>					
						<sakai:button_bar_item
							action="#{SyllabusTool.processAddAttachRedirect}" 
							value="#{msgs.add_attach}"/>
					</sakai:button_bar>							
	
					<h:outputText value="" styleClass="alertMessage"  rendered="#{SyllabusTool.displayEvilTagMsg}"/>
				    <h:outputText value="#{msgs.empty_content_validate} #{SyllabusTool.evilTagMsg}" styleClass="alertMessage"  rendered="#{SyllabusTool.displayEvilTagMsg}"/>

					<syllabus:syllabus_table value="#{SyllabusTool.allAttachments}" var="eachAttach" summary="#{msgs.edit_att_list_summary}" styleClass="listHier lines nolines">
					  <h:column rendered="#{!empty SyllabusTool.allAttachments}">
							<f:facet name="header">
								<h:outputText value="#{msgs.attachmentTitle}" />
							</f:facet>
							<f:verbatim><h5></f:verbatim>
							<h:graphicImage url="/syllabus/excel.gif" rendered="#{eachAttach.type == 'application/vnd.ms-excel'}"/>
							<h:graphicImage url="/syllabus/html.gif" rendered="#{eachAttach.type == 'text/html'}"/>
							<h:graphicImage url="/syllabus/pdf.gif" rendered="#{eachAttach.type == 'application/pdf'}"/>
							<h:graphicImage url="/syllabus/ppt.gif" rendered="#{eachAttach.type == 'application/vnd.ms-powerpoint'}"/>
							<h:graphicImage url="/syllabus/text.gif" rendered="#{eachAttach.type == 'text/plain'}"/>
							<h:graphicImage url="/syllabus/word.gif" rendered="#{eachAttach.type == 'application/msword'}"/>
							<h:outputText value="#{eachAttach.name}"/>
							<f:verbatim></h5></f:verbatim>
							<f:verbatim><div class="itemAction"></f:verbatim>

							<h:commandLink action="#{SyllabusTool.processDeleteAttach}" 
								onfocus="document.forms[0].onsubmit();" title="#{msgs.removeAttachmentLink} #{eachAttach.name}">
								<h:outputText value="#{msgs.mainEditHeaderRemove}"/>
								<f:param value="#{eachAttach.syllabusAttachId}" name="syllabus_current_attach"/>
							</h:commandLink>
							<f:verbatim></div></f:verbatim>
						</h:column>
					  <h:column rendered="#{!empty SyllabusTool.allAttachments}">
							<f:facet name="header">
								<h:outputText value="#{msgs.size}" />
							</f:facet>
							<h:outputText value="#{eachAttach.size}"/>
						</h:column>
					  <h:column rendered="#{!empty SyllabusTool.allAttachments}">
							<f:facet name="header">
		  			    <h:outputText value="#{msgs.type}" />
							</f:facet>
							<h:outputText value="#{eachAttach.type}"/>
						</h:column>
					  <h:column rendered="#{!empty SyllabusTool.allAttachments}">
							<f:facet name="header">
								<h:outputText value="#{msgs.created_by}" />
							</f:facet>
							<h:outputText value="#{eachAttach.createdBy}"/>
						</h:column>
					  <h:column rendered="#{!empty SyllabusTool.allAttachments}">
							<f:facet name="header">
								<h:outputText value="#{msgs.last_modified}" />
							</f:facet>
							<h:outputText value="#{eachAttach.lastModifiedBy}"/>
						</h:column>
					</syllabus:syllabus_table>

					<h:panelGrid columns="1" styleClass="jsfFormTable" summary="layout">
						<h:panelGroup styleClass="shorttext">
							<h:outputLabel for="list1">
								<h:outputText value="#{msgs.email_notify}"/>
							</h:outputLabel>
							<h:selectOneListbox size = "1"  id = "list1" value="#{SyllabusTool.entry.entry.emailNotification}">
								<f:selectItem itemLabel="#{msgs.notifyNone}" itemValue="none"/>
								<f:selectItem itemLabel="#{msgs.notifyHigh}" itemValue="high"/>
								<f:selectItem itemLabel="#{msgs.notifyLow}" itemValue="low"/>
							</h:selectOneListbox>
							</h:panelGroup>
						</h:panelGrid>

				<sakai:button_bar>
					<sakai:button_bar_item
						action="#{SyllabusTool.processReadPost}"
						styleClass="active"
						value="#{msgs.bar_post}"
						accesskey="s" />
					<sakai:button_bar_item
						action="#{SyllabusTool.processReadPreview}"
						value="#{msgs.bar_preview}" 
						accesskey="v"	/>
					<sakai:button_bar_item
						action="#{SyllabusTool.processReadSave}"
						value="#{msgs.bar_save_draft}" 
						accesskey="d" />
					<sakai:button_bar_item
						action="#{SyllabusTool.processReadCancel}"
						value="#{msgs.cancel}" 
						accesskey="x" />
				</sakai:button_bar>

			</h:form>
		</sakai:view_content>
	</sakai:view_container>
</f:view>
