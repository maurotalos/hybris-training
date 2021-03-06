<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="action" tagdir="/WEB-INF/tags/responsive/action" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<c:set var="isForceInStock" value="${product.stock.stockLevelStatus.code eq 'inStock' and empty product.stock.stockLevel}"/>
<c:choose> 
  <c:when test="${isForceInStock}">
    <c:set var="maxQty" value="FORCE_IN_STOCK"/>
  </c:when>
  <c:otherwise>
    <c:set var="maxQty" value="${product.stock.stockLevel}"/>
  </c:otherwise>
</c:choose>

<c:set var="qtyMinus" value="1" />

<c:set var="symbolDefsPath" value="${contextPath}/_ui/addons/talosacceleratoraddon/responsive/common/images/symbol-defs.svg"/>

<div class="addtocart-component">
	<div class="qty-selector-wp">
		<c:if test="${empty showAddToCart ? true : showAddToCart}">
			<div class="title"><spring:theme code="basket.page.quantity"/></div>
			<div class="qty-selector input-group js-qty-selector">
				<svg class="icon icon-minus tc-minus js-qty-selector-minus"><use xlink:href="${symbolDefsPath}#icon-minus"></use></svg>
				<input type="text" maxlength="3" class="form-control js-qty-selector-input" size="1" value="${qtyMinus}" data-max="${maxQty}" data-min="1" name="pdpAddtoCartInput"  id="pdpAddtoCartInput" />
				<svg class="icon icon-plus tc-plus js-qty-selector-plus"><use xlink:href="${symbolDefsPath}#icon-plus"></use></svg>
			</div>
		</c:if>
		<c:if test="${product.stock.stockLevel gt 0}">
			<c:set var="productStockLevel">${product.stock.stockLevel}&nbsp;
				<spring:theme code="product.variants.in.stock"/>
			</c:set>
		</c:if>
		<c:if test="${product.stock.stockLevelStatus.code eq 'lowStock'}">
			<c:set var="productStockLevel">
				<spring:theme code="product.variants.only.left" arguments="${product.stock.stockLevel}"/>
			</c:set>
		</c:if>
		<c:if test="${isForceInStock}">
			<c:set var="productStockLevel">
				<spring:theme code="product.variants.available"/>
			</c:set>
		</c:if>
		<div class="stock-wrapper clearfix">
			${productStockLevel}
		</div>
	</div>

	 <div class="actions">
        <c:if test="${multiDimensionalProduct}" >
                <c:url value="${product.url}/orderForm" var="productOrderFormUrl"/>
                <a href="${productOrderFormUrl}" class="btn btn-default btn-block btn-icon js-add-to-cart glyphicon-list-alt">
                    <spring:theme code="order.form" />
                </a>
        </c:if>
        <action:actions element="div"  parentComponent="${component}"/>
    </div>
</div>