!function(e){"function"==typeof define&&define.amd?define(["jquery"],e):e("object"==typeof exports?require("jquery"):jQuery)}(function(e){var t=0,i=Array.prototype.slice;e.cleanData=function(t){return function(i){var n,r,o;for(o=0;null!=(r=i[o]);o++)try{n=e._data(r,"events"),n&&n.remove&&e(r).triggerHandler("remove")}catch(e){}t(i)}}(e.cleanData),e.widget=function(t,i,n){var r,o,s,a,l={},u=t.split(".")[0];return t=t.split(".")[1],r=u+"-"+t,n||(n=i,i=e.Widget),e.expr[":"][r.toLowerCase()]=function(t){return!!e.data(t,r)},e[u]=e[u]||{},o=e[u][t],s=e[u][t]=function(e,t){if(!this._createWidget)return new s(e,t);arguments.length&&this._createWidget(e,t)},e.extend(s,o,{version:n.version,_proto:e.extend({},n),_childConstructors:[]}),a=new i,a.options=e.widget.extend({},a.options),e.each(n,function(t,n){if(!e.isFunction(n))return void(l[t]=n);l[t]=function(){var e=function(){return i.prototype[t].apply(this,arguments)},r=function(e){return i.prototype[t].apply(this,e)};return function(){var t,i=this._super,o=this._superApply;return this._super=e,this._superApply=r,t=n.apply(this,arguments),this._super=i,this._superApply=o,t}}()}),s.prototype=e.widget.extend(a,{widgetEventPrefix:o?a.widgetEventPrefix||t:t},l,{constructor:s,namespace:u,widgetName:t,widgetFullName:r}),o?(e.each(o._childConstructors,function(t,i){var n=i.prototype;e.widget(n.namespace+"."+n.widgetName,s,i._proto)}),delete o._childConstructors):i._childConstructors.push(s),e.widget.bridge(t,s),s},e.widget.extend=function(t){for(var n,r,o=i.call(arguments,1),s=0,a=o.length;s<a;s++)for(n in o[s])r=o[s][n],o[s].hasOwnProperty(n)&&r!==undefined&&(e.isPlainObject(r)?t[n]=e.isPlainObject(t[n])?e.widget.extend({},t[n],r):e.widget.extend({},r):t[n]=r);return t},e.widget.bridge=function(t,n){var r=n.prototype.widgetFullName||t;e.fn[t]=function(o){var s="string"==typeof o,a=i.call(arguments,1),l=this;return s?this.each(function(){var i,n=e.data(this,r);return"instance"===o?(l=n,!1):n?e.isFunction(n[o])&&"_"!==o.charAt(0)?(i=n[o].apply(n,a),i!==n&&i!==undefined?(l=i&&i.jquery?l.pushStack(i.get()):i,!1):void 0):e.error("no such method '"+o+"' for "+t+" widget instance"):e.error("cannot call methods on "+t+" prior to initialization; attempted to call method '"+o+"'")}):(a.length&&(o=e.widget.extend.apply(null,[o].concat(a))),this.each(function(){var t=e.data(this,r);t?(t.option(o||{}),t._init&&t._init()):e.data(this,r,new n(o,this))})),l}},e.Widget=function(){},e.Widget._childConstructors=[],e.Widget.prototype={widgetName:"widget",widgetEventPrefix:"",defaultElement:"<div>",options:{disabled:!1,create:null},_createWidget:function(i,n){n=e(n||this.defaultElement||this)[0],this.element=e(n),this.uuid=t++,this.eventNamespace="."+this.widgetName+this.uuid,this.bindings=e(),this.hoverable=e(),this.focusable=e(),n!==this&&(e.data(n,this.widgetFullName,this),this._on(!0,this.element,{remove:function(e){e.target===n&&this.destroy()}}),this.document=e(n.style?n.ownerDocument:n.document||n),this.window=e(this.document[0].defaultView||this.document[0].parentWindow)),this.options=e.widget.extend({},this.options,this._getCreateOptions(),i),this._create(),this._trigger("create",null,this._getCreateEventData()),this._init()},_getCreateOptions:e.noop,_getCreateEventData:e.noop,_create:e.noop,_init:e.noop,destroy:function(){this._destroy(),this.element.unbind(this.eventNamespace).removeData(this.widgetFullName).removeData(e.camelCase(this.widgetFullName)),this.widget().unbind(this.eventNamespace).removeAttr("aria-disabled").removeClass(this.widgetFullName+"-disabled ui-state-disabled"),this.bindings.unbind(this.eventNamespace),this.hoverable.removeClass("ui-state-hover"),this.focusable.removeClass("ui-state-focus")},_destroy:e.noop,widget:function(){return this.element},option:function(t,i){var n,r,o,s=t;if(0===arguments.length)return e.widget.extend({},this.options);if("string"==typeof t)if(s={},n=t.split("."),t=n.shift(),n.length){for(r=s[t]=e.widget.extend({},this.options[t]),o=0;o<n.length-1;o++)r[n[o]]=r[n[o]]||{},r=r[n[o]];if(t=n.pop(),1===arguments.length)return r[t]===undefined?null:r[t];r[t]=i}else{if(1===arguments.length)return this.options[t]===undefined?null:this.options[t];s[t]=i}return this._setOptions(s),this},_setOptions:function(e){var t;for(t in e)this._setOption(t,e[t]);return this},_setOption:function(e,t){return this.options[e]=t,"disabled"===e&&(this.widget().toggleClass(this.widgetFullName+"-disabled",!!t),t&&(this.hoverable.removeClass("ui-state-hover"),this.focusable.removeClass("ui-state-focus"))),this},enable:function(){return this._setOptions({disabled:!1})},disable:function(){return this._setOptions({disabled:!0})},_on:function(t,i,n){var r,o=this;"boolean"!=typeof t&&(n=i,i=t,t=!1),n?(i=r=e(i),this.bindings=this.bindings.add(i)):(n=i,i=this.element,r=this.widget()),e.each(n,function(n,s){function a(){if(t||!0!==o.options.disabled&&!e(this).hasClass("ui-state-disabled"))return("string"==typeof s?o[s]:s).apply(o,arguments)}"string"!=typeof s&&(a.guid=s.guid=s.guid||a.guid||e.guid++);var l=n.match(/^([\w:-]*)\s*(.*)$/),u=l[1]+o.eventNamespace,p=l[2];p?r.delegate(p,u,a):i.bind(u,a)})},_off:function(t,i){i=(i||"").split(" ").join(this.eventNamespace+" ")+this.eventNamespace,t.unbind(i).undelegate(i),this.bindings=e(this.bindings.not(t).get()),this.focusable=e(this.focusable.not(t).get()),this.hoverable=e(this.hoverable.not(t).get())},_delay:function(e,t){function i(){return("string"==typeof e?n[e]:e).apply(n,arguments)}var n=this;return setTimeout(i,t||0)},_hoverable:function(t){this.hoverable=this.hoverable.add(t),this._on(t,{mouseenter:function(t){e(t.currentTarget).addClass("ui-state-hover")},mouseleave:function(t){e(t.currentTarget).removeClass("ui-state-hover")}})},_focusable:function(t){this.focusable=this.focusable.add(t),this._on(t,{focusin:function(t){e(t.currentTarget).addClass("ui-state-focus")},focusout:function(t){e(t.currentTarget).removeClass("ui-state-focus")}})},_trigger:function(t,i,n){var r,o,s=this.options[t];if(n=n||{},i=e.Event(i),i.type=(t===this.widgetEventPrefix?t:this.widgetEventPrefix+t).toLowerCase(),i.target=this.element[0],o=i.originalEvent)for(r in o)r in i||(i[r]=o[r]);return this.element.trigger(i,n),!(e.isFunction(s)&&!1===s.apply(this.element[0],[i].concat(n))||i.isDefaultPrevented())}},e.each({show:"fadeIn",hide:"fadeOut"},function(t,i){e.Widget.prototype["_"+t]=function(n,r,o){"string"==typeof r&&(r={effect:r});var s,a=r?!0===r||"number"==typeof r?i:r.effect||i:t;r=r||{},"number"==typeof r&&(r={duration:r}),s=!e.isEmptyObject(r),r.complete=o,r.delay&&n.delay(r.delay),s&&e.effects&&e.effects.effect[a]?n[t](r):a!==t&&n[a]?n[a](r.duration,r.easing,o):n.queue(function(i){e(this)[t](),o&&o.call(n[0]),i()})}});e.widget}),function(e){"use strict";"function"==typeof define&&define.amd?define(["jquery"],e):e("object"==typeof exports?require("jquery"):window.jQuery)}(function(e){"use strict";var t=0;e.ajaxTransport("iframe",function(i){if(i.async){var n,r,o,s=i.initialIframeSrc||"javascript:false;";return{send:function(a,l){n=e('<form style="display:none;"></form>'),n.attr("accept-charset",i.formAcceptCharset),o=/\?/.test(i.url)?"&":"?","DELETE"===i.type?(i.url=i.url+o+"_method=DELETE",i.type="POST"):"PUT"===i.type?(i.url=i.url+o+"_method=PUT",i.type="POST"):"PATCH"===i.type&&(i.url=i.url+o+"_method=PATCH",i.type="POST"),t+=1,r=e('<iframe src="'+s+'" name="iframe-transport-'+t+'"></iframe>').bind("load",function(){var t,o=e.isArray(i.paramName)?i.paramName:[i.paramName];r.unbind("load").bind("load",function(){var t;try{if(t=r.contents(),!t.length||!t[0].firstChild)throw new Error}catch(e){t=undefined}l(200,"success",{iframe:t}),e('<iframe src="'+s+'"></iframe>').appendTo(n),window.setTimeout(function(){n.remove()},0)}),n.prop("target",r.prop("name")).prop("action",i.url).prop("method",i.type),i.formData&&e.each(i.formData,function(t,i){e('<input type="hidden"/>').prop("name",i.name).val(i.value).appendTo(n)}),i.fileInput&&i.fileInput.length&&"POST"===i.type&&(t=i.fileInput.clone(),i.fileInput.after(function(e){return t[e]}),i.paramName&&i.fileInput.each(function(t){e(this).prop("name",o[t]||i.paramName)}),n.append(i.fileInput).prop("enctype","multipart/form-data").prop("encoding","multipart/form-data"),i.fileInput.removeAttr("form")),n.submit(),t&&t.length&&i.fileInput.each(function(i,n){var r=e(t[i]);e(n).prop("name",r.prop("name")).attr("form",r.attr("form")),r.replaceWith(n)})}),n.append(r).appendTo(document.body)},abort:function(){r&&r.unbind("load").prop("src",s),n&&n.remove()}}}}),e.ajaxSetup({converters:{"iframe text":function(t){return t&&e(t[0].body).text()},"iframe json":function(t){return t&&e.parseJSON(e(t[0].body).text())},"iframe html":function(t){return t&&e(t[0].body).html()},"iframe xml":function(t){var i=t&&t[0];return i&&e.isXMLDoc(i)?i:e.parseXML(i.XMLDocument&&i.XMLDocument.xml||e(i.body).html())},"iframe script":function(t){return t&&e.globalEval(e(t[0].body).text())}}})}),function(e){"use strict";"function"==typeof define&&define.amd?define(["jquery","jquery.ui.widget"],e):"object"==typeof exports?e(require("jquery"),require("./vendor/jquery.ui.widget")):e(window.jQuery)}(function(e){"use strict";function t(t){var i="dragover"===t;return function(n){n.dataTransfer=n.originalEvent&&n.originalEvent.dataTransfer;var r=n.dataTransfer;r&&-1!==e.inArray("Files",r.types)&&!1!==this._trigger(t,e.Event(t,{delegatedEvent:n}))&&(n.preventDefault(),i&&(r.dropEffect="copy"))}}e.support.fileInput=!(new RegExp("(Android (1\\.[0156]|2\\.[01]))|(Windows Phone (OS 7|8\\.0))|(XBLWP)|(ZuneWP)|(WPDesktop)|(w(eb)?OSBrowser)|(webOS)|(Kindle/(1\\.0|2\\.[05]|3\\.0))").test(window.navigator.userAgent)||e('<input type="file">').prop("disabled")),e.support.xhrFileUpload=!(!window.ProgressEvent||!window.FileReader),e.support.xhrFormDataFileUpload=!!window.FormData,e.support.blobSlice=window.Blob&&(Blob.prototype.slice||Blob.prototype.webkitSlice||Blob.prototype.mozSlice),e.widget("blueimp.fileupload",{options:{dropZone:e(document),pasteZone:undefined,fileInput:undefined,replaceFileInput:!0,paramName:undefined,singleFileUploads:!0,limitMultiFileUploads:undefined,limitMultiFileUploadSize:undefined,limitMultiFileUploadSizeOverhead:512,sequentialUploads:!1,limitConcurrentUploads:undefined,forceIframeTransport:!1,redirect:undefined,redirectParamName:undefined,postMessage:undefined,multipart:!0,maxChunkSize:undefined,uploadedBytes:undefined,recalculateProgress:!0,progressInterval:100,bitrateInterval:500,autoUpload:!0,messages:{uploadedBytes:"Uploaded bytes exceed file size"},i18n:function(t,i){return t=this.messages[t]||t.toString(),i&&e.each(i,function(e,i){t=t.replace("{"+e+"}",i)}),t},formData:function(e){return e.serializeArray()},add:function(t,i){if(t.isDefaultPrevented())return!1;(i.autoUpload||!1!==i.autoUpload&&e(this).fileupload("option","autoUpload"))&&i.process().done(function(){i.submit()})},processData:!1,contentType:!1,cache:!1,timeout:0},_specialOptions:["fileInput","dropZone","pasteZone","multipart","forceIframeTransport"],_blobSlice:e.support.blobSlice&&function(){return(this.slice||this.webkitSlice||this.mozSlice).apply(this,arguments)},_BitrateTimer:function(){this.timestamp=Date.now?Date.now():(new Date).getTime(),this.loaded=0,this.bitrate=0,this.getBitrate=function(e,t,i){var n=e-this.timestamp;return(!this.bitrate||!i||n>i)&&(this.bitrate=(t-this.loaded)*(1e3/n)*8,this.loaded=t,this.timestamp=e),this.bitrate}},_isXHRUpload:function(t){return!t.forceIframeTransport&&(!t.multipart&&e.support.xhrFileUpload||e.support.xhrFormDataFileUpload)},_getFormData:function(t){var i;return"function"===e.type(t.formData)?t.formData(t.form):e.isArray(t.formData)?t.formData:"object"===e.type(t.formData)?(i=[],e.each(t.formData,function(e,t){i.push({name:e,value:t})}),i):[]},_getTotal:function(t){var i=0;return e.each(t,function(e,t){i+=t.size||1}),i},_initProgressObject:function(t){var i={loaded:0,total:0,bitrate:0};t._progress?e.extend(t._progress,i):t._progress=i},_initResponseObject:function(e){var t;if(e._response)for(t in e._response)e._response.hasOwnProperty(t)&&delete e._response[t];else e._response={}},_onProgress:function(t,i){if(t.lengthComputable){var n,r=Date.now?Date.now():(new Date).getTime();if(i._time&&i.progressInterval&&r-i._time<i.progressInterval&&t.loaded!==t.total)return;i._time=r,n=Math.floor(t.loaded/t.total*(i.chunkSize||i._progress.total))+(i.uploadedBytes||0),this._progress.loaded+=n-i._progress.loaded,this._progress.bitrate=this._bitrateTimer.getBitrate(r,this._progress.loaded,i.bitrateInterval),i._progress.loaded=i.loaded=n,i._progress.bitrate=i.bitrate=i._bitrateTimer.getBitrate(r,n,i.bitrateInterval),this._trigger("progress",e.Event("progress",{delegatedEvent:t}),i),this._trigger("progressall",e.Event("progressall",{delegatedEvent:t}),this._progress)}},_initProgressListener:function(t){var i=this,n=t.xhr?t.xhr():e.ajaxSettings.xhr();n.upload&&(e(n.upload).bind("progress",function(e){var n=e.originalEvent;e.lengthComputable=n.lengthComputable,e.loaded=n.loaded,e.total=n.total,i._onProgress(e,t)}),t.xhr=function(){return n})},_isInstanceOf:function(e,t){return Object.prototype.toString.call(t)==="[object "+e+"]"},_initXHRData:function(t){var i,n=this,r=t.files[0],o=t.multipart||!e.support.xhrFileUpload,s="array"===e.type(t.paramName)?t.paramName[0]:t.paramName;t.headers=e.extend({},t.headers),t.contentRange&&(t.headers["Content-Range"]=t.contentRange),o&&!t.blob&&this._isInstanceOf("File",r)||(t.headers["Content-Disposition"]='attachment; filename="'+encodeURI(r.name)+'"'),o?e.support.xhrFormDataFileUpload&&(t.postMessage?(i=this._getFormData(t),t.blob?i.push({name:s,value:t.blob}):e.each(t.files,function(n,r){i.push({name:"array"===e.type(t.paramName)&&t.paramName[n]||s,value:r})})):(n._isInstanceOf("FormData",t.formData)?i=t.formData:(i=new FormData,e.each(this._getFormData(t),function(e,t){i.append(t.name,t.value)})),t.blob?i.append(s,t.blob,r.name):e.each(t.files,function(r,o){(n._isInstanceOf("File",o)||n._isInstanceOf("Blob",o))&&i.append("array"===e.type(t.paramName)&&t.paramName[r]||s,o,o.uploadName||o.name)})),t.data=i):(t.contentType=r.type||"application/octet-stream",t.data=t.blob||r),t.blob=null},_initIframeSettings:function(t){var i=e("<a></a>").prop("href",t.url).prop("host");t.dataType="iframe "+(t.dataType||""),t.formData=this._getFormData(t),t.redirect&&i&&i!==location.host&&t.formData.push({name:t.redirectParamName||"redirect",value:t.redirect})},_initDataSettings:function(e){this._isXHRUpload(e)?(this._chunkedUpload(e,!0)||(e.data||this._initXHRData(e),this._initProgressListener(e)),e.postMessage&&(e.dataType="postmessage "+(e.dataType||""))):this._initIframeSettings(e)},_getParamName:function(t){var i=e(t.fileInput),n=t.paramName;return n?e.isArray(n)||(n=[n]):(n=[],i.each(function(){for(var t=e(this),i=t.prop("name")||"files[]",r=(t.prop("files")||[1]).length;r;)n.push(i),r-=1}),n.length||(n=[i.prop("name")||"files[]"])),n},_initFormSettings:function(t){t.form&&t.form.length||(t.form=e(t.fileInput.prop("form")),t.form.length||(t.form=e(this.options.fileInput.prop("form")))),t.paramName=this._getParamName(t),t.url||(t.url=t.form.prop("action")||location.href),t.type=(t.type||"string"===e.type(t.form.prop("method"))&&t.form.prop("method")||"").toUpperCase(),"POST"!==t.type&&"PUT"!==t.type&&"PATCH"!==t.type&&(t.type="POST"),t.formAcceptCharset||(t.formAcceptCharset=t.form.attr("accept-charset"))},_getAJAXSettings:function(t){var i=e.extend({},this.options,t);return this._initFormSettings(i),this._initDataSettings(i),i},_getDeferredState:function(e){return e.state?e.state():e.isResolved()?"resolved":e.isRejected()?"rejected":"pending"},_enhancePromise:function(e){return e.success=e.done,e.error=e.fail,e.complete=e.always,e},_getXHRPromise:function(t,i,n){var r=e.Deferred(),o=r.promise();return i=i||this.options.context||o,!0===t?r.resolveWith(i,n):!1===t&&r.rejectWith(i,n),o.abort=r.promise,this._enhancePromise(o)},_addConvenienceMethods:function(t,i){var n=this,r=function(t){return e.Deferred().resolveWith(n,t).promise()};i.process=function(t,o){return(t||o)&&(i._processQueue=this._processQueue=(this._processQueue||r([this])).then(function(){return i.errorThrown?e.Deferred().rejectWith(n,[i]).promise():r(arguments)}).then(t,o)),this._processQueue||r([this])},i.submit=function(){return"pending"!==this.state()&&(i.jqXHR=this.jqXHR=!1!==n._trigger("submit",e.Event("submit",{delegatedEvent:t}),this)&&n._onSend(t,this)),this.jqXHR||n._getXHRPromise()},i.abort=function(){return this.jqXHR?this.jqXHR.abort():(this.errorThrown="abort",n._trigger("fail",null,this),n._getXHRPromise(!1))},i.state=function(){return this.jqXHR?n._getDeferredState(this.jqXHR):this._processQueue?n._getDeferredState(this._processQueue):void 0},i.processing=function(){return!this.jqXHR&&this._processQueue&&"pending"===n._getDeferredState(this._processQueue)},i.progress=function(){return this._progress},i.response=function(){return this._response}},_getUploadedBytes:function(e){var t=e.getResponseHeader("Range"),i=t&&t.split("-"),n=i&&i.length>1&&parseInt(i[1],10);return n&&n+1},_chunkedUpload:function(t,i){t.uploadedBytes=t.uploadedBytes||0;var n,r,o=this,s=t.files[0],a=s.size,l=t.uploadedBytes,u=t.maxChunkSize||a,p=this._blobSlice,d=e.Deferred(),f=d.promise();return!(!(this._isXHRUpload(t)&&p&&(l||u<a))||t.data)&&(!!i||(l>=a?(s.error=t.i18n("uploadedBytes"),this._getXHRPromise(!1,t.context,[null,"error",s.error])):(r=function(){var i=e.extend({},t),f=i._progress.loaded;i.blob=p.call(s,l,l+u,s.type),i.chunkSize=i.blob.size,i.contentRange="bytes "+l+"-"+(l+i.chunkSize-1)+"/"+a,o._initXHRData(i),o._initProgressListener(i),n=(!1!==o._trigger("chunksend",null,i)&&e.ajax(i)||o._getXHRPromise(!1,i.context)).done(function(n,s,u){l=o._getUploadedBytes(u)||l+i.chunkSize,f+i.chunkSize-i._progress.loaded&&o._onProgress(e.Event("progress",{lengthComputable:!0,loaded:l-i.uploadedBytes,total:l-i.uploadedBytes}),i),t.uploadedBytes=i.uploadedBytes=l,i.result=n,i.textStatus=s,i.jqXHR=u,o._trigger("chunkdone",null,i),o._trigger("chunkalways",null,i),l<a?r():d.resolveWith(i.context,[n,s,u])}).fail(function(e,t,n){i.jqXHR=e,i.textStatus=t,i.errorThrown=n,o._trigger("chunkfail",null,i),o._trigger("chunkalways",null,i),d.rejectWith(i.context,[e,t,n])})},this._enhancePromise(f),f.abort=function(){return n.abort()},r(),f)))},_beforeSend:function(e,t){0===this._active&&(this._trigger("start"),this._bitrateTimer=new this._BitrateTimer,this._progress.loaded=this._progress.total=0,this._progress.bitrate=0),this._initResponseObject(t),this._initProgressObject(t),t._progress.loaded=t.loaded=t.uploadedBytes||0,t._progress.total=t.total=this._getTotal(t.files)||1,t._progress.bitrate=t.bitrate=0,this._active+=1,this._progress.loaded+=t.loaded,this._progress.total+=t.total},_onDone:function(t,i,n,r){var o=r._progress.total,s=r._response;r._progress.loaded<o&&this._onProgress(e.Event("progress",{lengthComputable:!0,loaded:o,total:o}),r),s.result=r.result=t,s.textStatus=r.textStatus=i,s.jqXHR=r.jqXHR=n,this._trigger("done",null,r)},_onFail:function(e,t,i,n){var r=n._response;n.recalculateProgress&&(this._progress.loaded-=n._progress.loaded,this._progress.total-=n._progress.total),r.jqXHR=n.jqXHR=e,r.textStatus=n.textStatus=t,r.errorThrown=n.errorThrown=i,this._trigger("fail",null,n)},_onAlways:function(e,t,i,n){this._trigger("always",null,n)},_onSend:function(t,i){i.submit||this._addConvenienceMethods(t,i);var n,r,o,s,a=this,l=a._getAJAXSettings(i),u=function(){return a._sending+=1,l._bitrateTimer=new a._BitrateTimer,n=n||((r||!1===a._trigger("send",e.Event("send",{delegatedEvent:t}),l))&&a._getXHRPromise(!1,l.context,r)||a._chunkedUpload(l)||e.ajax(l)).done(function(e,t,i){a._onDone(e,t,i,l)}).fail(function(e,t,i){a._onFail(e,t,i,l)}).always(function(e,t,i){if(a._onAlways(e,t,i,l),a._sending-=1,a._active-=1,l.limitConcurrentUploads&&l.limitConcurrentUploads>a._sending)for(var n=a._slots.shift();n;){if("pending"===a._getDeferredState(n)){n.resolve();break}n=a._slots.shift()}0===a._active&&a._trigger("stop")})};return this._beforeSend(t,l),this.options.sequentialUploads||this.options.limitConcurrentUploads&&this.options.limitConcurrentUploads<=this._sending?(this.options.limitConcurrentUploads>1?(o=e.Deferred(),this._slots.push(o),s=o.then(u)):(this._sequence=this._sequence.then(u,u),s=this._sequence),s.abort=function(){return r=[undefined,"abort","abort"],n?n.abort():(o&&o.rejectWith(l.context,r),u())},this._enhancePromise(s)):u()},_onAdd:function(t,i){var n,r,o,s,a=this,l=!0,u=e.extend({},this.options,i),p=i.files,d=p.length,f=u.limitMultiFileUploads,c=u.limitMultiFileUploadSize,h=u.limitMultiFileUploadSizeOverhead,g=0,m=this._getParamName(u),_=0;if(!d)return!1;if(c&&p[0].size===undefined&&(c=undefined),(u.singleFileUploads||f||c)&&this._isXHRUpload(u))if(u.singleFileUploads||c||!f)if(!u.singleFileUploads&&c)for(o=[],n=[],s=0;s<d;s+=1)g+=p[s].size+h,(s+1===d||g+p[s+1].size+h>c||f&&s+1-_>=f)&&(o.push(p.slice(_,s+1)),r=m.slice(_,s+1),r.length||(r=m),n.push(r),_=s+1,g=0);else n=m;else for(o=[],n=[],s=0;s<d;s+=f)o.push(p.slice(s,s+f)),r=m.slice(s,s+f),r.length||(r=m),n.push(r);else o=[p],n=[m];return i.originalFiles=p,e.each(o||p,function(r,s){var u=e.extend({},i);return u.files=o?s:[s],u.paramName=n[r],a._initResponseObject(u),a._initProgressObject(u),a._addConvenienceMethods(t,u),l=a._trigger("add",e.Event("add",{delegatedEvent:t}),u)}),l},_replaceFileInput:function(t){var i=t.fileInput,n=i.clone(!0),r=i.is(document.activeElement);t.fileInputClone=n,e("<form></form>").append(n)[0].reset(),i.after(n).detach(),r&&n.focus(),e.cleanData(i.unbind("remove")),this.options.fileInput=this.options.fileInput.map(function(e,t){return t===i[0]?n[0]:t}),i[0]===this.element[0]&&(this.element=n)},_handleFileTreeEntry:function(t,i){var n,r=this,o=e.Deferred(),s=function(e){e&&!e.entry&&(e.entry=t),o.resolve([e])},a=function(e){r._handleFileTreeEntries(e,i+t.name+"/").done(function(e){o.resolve(e)}).fail(s)},l=function(){n.readEntries(function(e){e.length?(u=u.concat(e),l()):a(u)},s)},u=[];return i=i||"",t.isFile?t._file?(t._file.relativePath=i,o.resolve(t._file)):t.file(function(e){e.relativePath=i,o.resolve(e)},s):t.isDirectory?(n=t.createReader(),l()):o.resolve([]),o.promise()},_handleFileTreeEntries:function(t,i){var n=this;return e.when.apply(e,e.map(t,function(e){return n._handleFileTreeEntry(e,i)})).then(function(){return Array.prototype.concat.apply([],arguments)})},_getDroppedFiles:function(t){t=t||{};var i=t.items;return i&&i.length&&(i[0].webkitGetAsEntry||i[0].getAsEntry)?this._handleFileTreeEntries(e.map(i,function(e){var t;return e.webkitGetAsEntry?(t=e.webkitGetAsEntry(),t&&(t._file=e.getAsFile()),t):e.getAsEntry()})):e.Deferred().resolve(e.makeArray(t.files)).promise()},_getSingleFileInputFiles:function(t){t=e(t);var i,n,r=t.prop("webkitEntries")||t.prop("entries");if(r&&r.length)return this._handleFileTreeEntries(r);if(i=e.makeArray(t.prop("files")),i.length)i[0].name===undefined&&i[0].fileName&&e.each(i,function(e,t){t.name=t.fileName,t.size=t.fileSize});else{if(!(n=t.prop("value")))return e.Deferred().resolve([]).promise();i=[{name:n.replace(/^.*\\/,"")}]}return e.Deferred().resolve(i).promise()},_getFileInputFiles:function(t){return t instanceof e&&1!==t.length?e.when.apply(e,e.map(t,this._getSingleFileInputFiles)).then(function(){return Array.prototype.concat.apply([],arguments)}):this._getSingleFileInputFiles(t)},_onChange:function(t){var i=this,n={fileInput:e(t.target),form:e(t.target.form)};this._getFileInputFiles(n.fileInput).always(function(r){n.files=r,i.options.replaceFileInput&&i._replaceFileInput(n),!1!==i._trigger("change",e.Event("change",{delegatedEvent:t}),n)&&i._onAdd(t,n)})},_onPaste:function(t){var i=t.originalEvent&&t.originalEvent.clipboardData&&t.originalEvent.clipboardData.items,n={files:[]};i&&i.length&&(e.each(i,function(e,t){var i=t.getAsFile&&t.getAsFile();i&&n.files.push(i)}),!1!==this._trigger("paste",e.Event("paste",{delegatedEvent:t}),n)&&this._onAdd(t,n))},_onDrop:function(t){t.dataTransfer=t.originalEvent&&t.originalEvent.dataTransfer;var i=this,n=t.dataTransfer,r={};n&&n.files&&n.files.length&&(t.preventDefault(),this._getDroppedFiles(n).always(function(n){r.files=n,!1!==i._trigger("drop",e.Event("drop",{delegatedEvent:t}),r)&&i._onAdd(t,r)}))},_onDragOver:t("dragover"),_onDragEnter:t("dragenter"),_onDragLeave:t("dragleave"),_initEventHandlers:function(){this._isXHRUpload(this.options)&&(this._on(this.options.dropZone,{dragover:this._onDragOver,drop:this._onDrop,dragenter:this._onDragEnter,dragleave:this._onDragLeave}),this._on(this.options.pasteZone,{paste:this._onPaste})),e.support.fileInput&&this._on(this.options.fileInput,{change:this._onChange})},_destroyEventHandlers:function(){this._off(this.options.dropZone,"dragenter dragleave dragover drop"),this._off(this.options.pasteZone,"paste"),this._off(this.options.fileInput,"change")},_setOption:function(t,i){var n=-1!==e.inArray(t,this._specialOptions);n&&this._destroyEventHandlers(),this._super(t,i),n&&(this._initSpecialOptions(),this._initEventHandlers())},_initSpecialOptions:function(){var t=this.options;t.fileInput===undefined?t.fileInput=this.element.is('input[type="file"]')?this.element:this.element.find('input[type="file"]'):t.fileInput instanceof e||(t.fileInput=e(t.fileInput)),t.dropZone instanceof e||(t.dropZone=e(t.dropZone)),t.pasteZone instanceof e||(t.pasteZone=e(t.pasteZone))},_getRegExp:function(e){var t=e.split("/"),i=t.pop();return t.shift(),new RegExp(t.join("/"),i)},_isRegExpOption:function(t,i){return"url"!==t&&"string"===e.type(i)&&/^\/.*\/[igm]{0,3}$/.test(i)},_initDataAttributes:function(){var t=this,i=this.options,n=this.element.data();e.each(this.element[0].attributes,function(e,r){var o,s=r.name.toLowerCase();/^data-/.test(s)&&(s=s.slice(5).replace(/-[a-z]/g,function(e){return e.charAt(1).toUpperCase()}),o=n[s],t._isRegExpOption(s,o)&&(o=t._getRegExp(o)),i[s]=o)})},_create:function(){this._initDataAttributes(),this._initSpecialOptions(),this._slots=[],this._sequence=this._getXHRPromise(!0),this._sending=this._active=0,this._initProgressObject(this),this._initEventHandlers()},active:function(){return this._active},progress:function(){return this._progress},add:function(t){var i=this;t&&!this.options.disabled&&(t.fileInput&&!t.files?this._getFileInputFiles(t.fileInput).always(function(e){t.files=e,i._onAdd(null,t)}):(t.files=e.makeArray(t.files),this._onAdd(null,t)))},send:function(t){if(t&&!this.options.disabled){if(t.fileInput&&!t.files){var i,n,r=this,o=e.Deferred(),s=o.promise();return s.abort=function(){return n=!0,i?i.abort():(o.reject(null,"abort","abort"),s)},this._getFileInputFiles(t.fileInput).always(function(e){if(!n){if(!e.length)return void o.reject();t.files=e,i=r._onSend(null,t),i.then(function(e,t,i){o.resolve(e,t,i)},function(e,t,i){o.reject(e,t,i)})}}),this._enhancePromise(s)}if(t.files=e.makeArray(t.files),t.files.length)return this._onSend(null,t)}return this._getXHRPromise(!1,t&&t.context)}})});