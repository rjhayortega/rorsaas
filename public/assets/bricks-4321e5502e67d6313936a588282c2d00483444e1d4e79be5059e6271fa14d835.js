!function(n,t){"object"==typeof exports&&"undefined"!=typeof module?module.exports=t():"function"==typeof define&&define.amd?define(t):n.Bricks=t()}(this,function(){"use strict";var n=Object.assign||function(n){for(var t=1;t<arguments.length;t++){var e=arguments[t];for(var i in e)Object.prototype.hasOwnProperty.call(e,i)&&(n[i]=e[i])}return n},t=function(){function t(n,t){return u[n]=u[n]||[],u[n].push(t),this}function e(n,e){return e._once=!0,t(n,e),this}function i(n){var t=arguments.length>1&&arguments[1]!==undefined&&arguments[1];return t?u[n].splice(u[n].indexOf(t),1):delete u[n],this}function r(n){for(var t=this,e=arguments.length,r=Array(e>1?e-1:0),o=1;o<e;o++)r[o-1]=arguments[o];var c=u[n]&&u[n].slice();return c&&c.forEach(function(e){e._once&&i(n,e),e.apply(t,r)}),this}var o=arguments.length>0&&arguments[0]!==undefined?arguments[0]:{},u=Object.create(null);return n({},o,{on:t,once:e,off:i,emit:r})};return function(){function n(n){n.forEach(function(n){return n()})}function e(n){arguments.length>1&&arguments[1]!==undefined?arguments[1]:document;return Array.prototype.slice.call(n)}function i(n){return Array.apply(null,Array(n)).map(function(){return 0})}function r(){return B.map(function(n){return n.mq&&window.matchMedia("(min-width: "+n.mq+")").matches}).indexOf(!0)}function o(){x=r()}function u(){O=-1===x?B[B.length-1]:B[x]}function c(){A=i(O.columns)}function a(){q=P[g?"new":"all"]()}function f(){0!==q.length&&(z=q.map(function(n){return n.clientWidth}),L=q.map(function(n){return n.clientHeight}))}function d(){q.forEach(function(n,t){b=A.indexOf(Math.min.apply(Math,A)),n.style.position="absolute",k=A[b]+"px",E=b*z[t]+b*O.gutter+"px",F?(n.style.top=k,n.style.left=E):n.style.transform="translate3d("+E+", "+k+", 0)",n.setAttribute(_,""),M=z[t],j=L[t],M&&j&&(A[b]+=j+O.gutter)})}function l(){H.style.position="relative",H.style.width=O.columns*M+(O.columns-1)*O.gutter+"px",H.style.height=Math.max.apply(Math,A)-O.gutter+"px"}function s(){w||(window.requestAnimationFrame(p),w=!0)}function p(){x!==r()&&(h(),W.emit("resize",O)),w=!1}function h(){return g=!1,n(S.concat(T)),W.emit("pack")}function v(){return g=!0,n(T),W.emit("update")}function m(){var n=!(arguments.length>0&&arguments[0]!==undefined)||arguments[0],t=n?"addEventListener":"removeEventListener";return window[t]("resize",s),W}var y=arguments.length>0&&arguments[0]!==undefined?arguments[0]:{},g=void 0,w=void 0,x=void 0,O=void 0,b=void 0,A=void 0,k=void 0,E=void 0,M=void 0,j=void 0,q=void 0,z=void 0,L=void 0,_=0===y.packed.indexOf("data-")?y.packed:"data-"+y.packed,B=y.sizes.slice().reverse(),F=!1!==y.position,H=y.container.nodeType?y.container:document.querySelector(y.container),P={all:function(){return e(H.children)},"new":function(){return e(H.children).filter(function(n){return!n.hasAttribute(""+_)})}},S=[o,u,c],T=[a,f,d,l],W=t({pack:h,update:v,resize:m});return W}});