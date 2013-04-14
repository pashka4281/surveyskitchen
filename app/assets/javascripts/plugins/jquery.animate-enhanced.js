
/*
jquery.animate-enhanced plugin v0.99.1
---
http://github.com/benbarnett/jQuery-Animate-Enhanced
http://benbarnett.net
@benpbarnett
*/
(function(c, J, K) {
    function P(a, b, c, f, m, l, h, q, r) {
        var u = !1;
        h = !0 === h && !0 === q;
        b = b || {};
        b.original || (b.original = {}, u = !0);
        b.properties = b.properties || {};
        b.secondary = b.secondary || {};
        q = b.meta;
        for (var n = b.original, g = b.properties, Q = b.secondary, C = s.length - 1; 0 <= C; C--) {
            var E = s[C] + "transition-property",
                F = s[C] + "transition-duration",
                j = s[C] + "transition-timing-function";
            c = h ? s[C] + "transform" : c;
            u && (n[E] = a.css(E) || "", n[F] = a.css(F) || "", n[j] = a.css(j) || "");
            Q[c] = h ? (!0 === r || !0 === G && !1 !== r) && L ? "translate3d(" + q.left + "px, " + q.top + "px, 0)" : "translate(" + q.left + "px," + q.top + "px)" : l;
            g[E] = (g[E] ? g[E] + "," : "") + c;
            g[F] = (g[F] ? g[F] + "," : "") + f + "ms";
            g[j] = (g[j] ? g[j] + "," : "") + m
        }
        return b
    }
    function A(a) {
        for (var c in a) return !1;
        return !0
    }
    function H(a) {
        return parseFloat(a.replace(a.match(/\D+$/), ""))
    }
    function M(a) {
        var c = !0;
        a.each(function(a, f) {
            return c = c && f.ownerDocument
        });
        return c
    }
    var R = "top right bottom left opacity height width".split(" "),
        I = ["top", "right", "bottom", "left"],
        s = ["-webkit-", "-moz-", "-o-", ""],
        S = ["avoidTransforms", "useTranslate3d", "leaveTransforms"],
        T = /^([+-]=)?([\d+-.]+)(.*)$/,
        U = /([A-Z])/g,
        V = {
            secondary: {},
            meta: {
                top: 0,
                right: 0,
                bottom: 0,
                left: 0
            }
        }, N = null,
        B = !1,
        y = (document.body || document.documentElement).style,
        O = void 0 !== y.WebkitTransition || void 0 !== y.MozTransition || void 0 !== y.OTransition || void 0 !== y.transition,
        L = "WebKitCSSMatrix" in window && "m11" in new WebKitCSSMatrix,
        G = L;
    c.expr && c.expr.filters && (N = c.expr.filters.animated, c.expr.filters.animated = function(a) {
        return c(a).data("events") && c(a).data("events")["webkitTransitionEnd oTransitionEnd transitionend"] ? !0 : N.call(this, a)
    });
    c.extend({
        toggle3DByDefault: function() {
            return G = !G
        },
        toggleDisabledByDefault: function() {
            return B = !B
        },
        setDisabledByDefault: function(a) {
            return B = a
        }
    });
    c.fn.translation = function() {
        if (!this[0]) return null;
        var a = window.getComputedStyle(this[0], null),
            c = {
                x: 0,
                y: 0
            };
        if (a) for (var p = s.length - 1; 0 <= p; p--) {
            var f = a.getPropertyValue(s[p] + "transform");
            if (f && /matrix/i.test(f)) {
                a = f.replace(/^matrix\(/i, "").split(/, |\)$/g);
                c = {
                    x: parseInt(a[4], 10),
                    y: parseInt(a[5], 10)
                };
                break
            }
        }
        return c
    };
    c.fn.animate = function(a,
    b, p, f) {
        a = a || {};
        var m = !("undefined" !== typeof a.bottom || "undefined" !== typeof a.right),
            l = c.speed(b, p, f),
            h = this,
            q = 0,
            r = function() {
                q--;
                0 === q && "function" === typeof l.complete && l.complete.apply(h, arguments)
            }, u;
        if (!(u = !0 === ("undefined" !== typeof a.avoidCSSTransitions ? a.avoidCSSTransitions : B))) if (!(u = !O)) if (!(u = A(a))) {
            var n;
            a: {
                for (n in a) if (("width" == n || "height" == n) && ("show" == a[n] || "hide" == a[n] || "toggle" == a[n])) {
                    n = !0;
                    break a
                }
                n = !1
            }
            u = n || 0 >= l.duration || !0 === c.fn.animate.defaults.avoidTransforms && !1 !== a.avoidTransforms
        }
        return u ? J.apply(this, arguments) : this[!0 === l.queue ? "queue" : "each"](function() {
            var g = c(this),
                b = c.extend({}, l),
                h = function(b) {
                    var f = g.data("jQe") || {
                        original: {}
                    }, e = {};
                    if (2 == b.eventPhase) {
                        if (!0 !== a.leaveTransforms) {
                            for (b = s.length - 1; 0 <= b; b--) e[s[b] + "transform"] = "";
                            if (m && "undefined" !== typeof f.meta) {
                                b = 0;
                                for (var d; d = I[b]; ++b) e[d] = f.meta[d + "_o"] + "px", c(this).css(d, e[d])
                            }
                        }
                        g.unbind("webkitTransitionEnd oTransitionEnd transitionend").css(f.original).css(e).data("jQe", null);
                        "hide" === a.opacity && g.css({
                            display: "none",
                            opacity: ""
                        });
                        r.call(this)
                    }
                }, f = {
                    bounce: "cubic-bezier(0.0, 0.35, .5, 1.3)",
                    linear: "linear",
                    swing: "ease-in-out",
                    easeInQuad: "cubic-bezier(0.550, 0.085, 0.680, 0.530)",
                    easeInCubic: "cubic-bezier(0.550, 0.055, 0.675, 0.190)",
                    easeInQuart: "cubic-bezier(0.895, 0.030, 0.685, 0.220)",
                    easeInQuint: "cubic-bezier(0.755, 0.050, 0.855, 0.060)",
                    easeInSine: "cubic-bezier(0.470, 0.000, 0.745, 0.715)",
                    easeInExpo: "cubic-bezier(0.950, 0.050, 0.795, 0.035)",
                    easeInCirc: "cubic-bezier(0.600, 0.040, 0.980, 0.335)",
                    easeInBack: "cubic-bezier(0.600, -0.280, 0.735, 0.045)",
                    easeOutQuad: "cubic-bezier(0.250, 0.460, 0.450, 0.940)",
                    easeOutCubic: "cubic-bezier(0.215, 0.610, 0.355, 1.000)",
                    easeOutQuart: "cubic-bezier(0.165, 0.840, 0.440, 1.000)",
                    easeOutQuint: "cubic-bezier(0.230, 1.000, 0.320, 1.000)",
                    easeOutSine: "cubic-bezier(0.390, 0.575, 0.565, 1.000)",
                    easeOutExpo: "cubic-bezier(0.190, 1.000, 0.220, 1.000)",
                    easeOutCirc: "cubic-bezier(0.075, 0.820, 0.165, 1.000)",
                    easeOutBack: "cubic-bezier(0.175, 0.885, 0.320, 1.275)",
                    easeInOutQuad: "cubic-bezier(0.455, 0.030, 0.515, 0.955)",
                    easeInOutCubic: "cubic-bezier(0.645, 0.045, 0.355, 1.000)",
                    easeInOutQuart: "cubic-bezier(0.770, 0.000, 0.175, 1.000)",
                    easeInOutQuint: "cubic-bezier(0.860, 0.000, 0.070, 1.000)",
                    easeInOutSine: "cubic-bezier(0.445, 0.050, 0.550, 0.950)",
                    easeInOutExpo: "cubic-bezier(1.000, 0.000, 0.000, 1.000)",
                    easeInOutCirc: "cubic-bezier(0.785, 0.135, 0.150, 0.860)",
                    easeInOutBack: "cubic-bezier(0.680, -0.550, 0.265, 1.550)"
                }, n = {}, f = f[b.easing || "swing"] ? f[b.easing || "swing"] : b.easing || "swing",
                j;
            for (j in a) if (-1 === c.inArray(j, S)) {
                var p = -1 < c.inArray(j, I),
                    k;
                var d = g,
                    x = a[j],
                    v = j,
                    t = p && !0 !== a.avoidTransforms;
                if ("d" == v) k = void 0;
                else if (M(d)) {
                    var e = T.exec(x);
                    k = "auto" === d.css(v) ? 0 : d.css(v);
                    k = "string" == typeof k ? H(k) : k;
                    "string" == typeof x && H(x);
                    var t = !0 === t ? 0 : k,
                        u = d.is(":hidden"),
                        w = d.translation();
                    "left" == v && (t = parseInt(k, 10) + w.x);
                    "right" == v && (t = parseInt(k, 10) + w.x);
                    "top" == v && (t = parseInt(k, 10) + w.y);
                    "bottom" == v && (t = parseInt(k, 10) + w.y);
                    !e && "show" == x ? (t = 1, u && d.css({
                        display: "LI" == d.context.tagName ? "list-item" : "block",
                        opacity: 0
                    })) : !e && "hide" == x && (t = 0);
                    e ? (d = parseFloat(e[2]), e[1] && (d = ("-=" === e[1] ? -1 : 1) * d + parseInt(t, 10)), k = d) : k = t
                } else k = void 0;
                if (e = !0 !== a.avoidTransforms) if (e = j, d = k, x = g, M(x)) {
                    v = -1 < c.inArray(e, R);
                    if (("width" == e || "height" == e || "opacity" == e) && parseFloat(d) === parseFloat(x.css(e))) v = !1;
                    e = v
                } else e = !1;
                if (e) {
                    e = g;
                    d = j;
                    x = b.duration;
                    v = f;
                    k = p && !0 === a.avoidTransforms ? k + "px" : k;
                    var p = p && !0 !== a.avoidTransforms,
                        t = m,
                        u = !0 === a.useTranslate3d,
                        w = (w = e.data("jQe")) && !A(w) ? w : c.extend(!0, {}, V),
                        z = k;
                    if (-1 < c.inArray(d, I)) {
                        var D = w.meta,
                            B = H(e.css(d)) || 0,
                            y = d + "_o",
                            z = k - B;
                        D[d] = z;
                        D[y] = "auto" == e.css(d) ? 0 + z : B + z || 0;
                        w.meta = D;
                        t && 0 === z && (z = 0 - D[y], D[d] = z, D[y] = 0)
                    }
                    e.data("jQe", P(e, w, d, x, v, z, p, t, u))
                } else n[j] = a[j]
            }
            g.unbind("webkitTransitionEnd oTransitionEnd transitionend");
            if ((j = g.data("jQe")) && !A(j) && !A(j.secondary)) {
                q++;
                g.css(j.properties);
                var G = j.secondary;
                setTimeout(function() {
                    g.bind("webkitTransitionEnd oTransitionEnd transitionend", h).css(G)
                })
            } else b.queue = !1;
            A(n) || (q++, J.apply(g, [n, {
                duration: b.duration,
                easing: c.easing[b.easing] ? b.easing : c.easing.swing ? "swing" : "linear",
                complete: r,
                queue: b.queue
            }]));
            return !0
        })
    };
    c.fn.animate.defaults = {};
    c.fn.stop = function(a, b, p) {
        if (!O) return K.apply(this, [a, b]);
        a && this.queue([]);
        this.each(function() {
            var f = c(this),
                m = f.data("jQe");
            if (m && !A(m)) {
                var l, h = {};
                if (b) {
                    if (h = m.secondary, !p && void 0 !== typeof m.meta.left_o || void 0 !== typeof m.meta.top_o) {
                        h.left = void 0 !== typeof m.meta.left_o ? m.meta.left_o : "auto";
                        h.top = void 0 !== typeof m.meta.top_o ? m.meta.top_o : "auto";
                        for (l = s.length - 1; 0 <= l; l--) h[s[l] + "transform"] = ""
                    }
                } else if (!A(m.secondary)) {
                    var q = window.getComputedStyle(f[0], null);
                    if (q) for (var r in m.secondary) if (m.secondary.hasOwnProperty(r) && (r = r.replace(U, "-$1").toLowerCase(), h[r] = q.getPropertyValue(r), !p && /matrix/i.test(h[r]))) {
                        l = h[r].replace(/^matrix\(/i, "").split(/, |\)$/g);
                        h.left = parseFloat(l[4]) + parseFloat(f.css("left")) + "px" || "auto";
                        h.top = parseFloat(l[5]) + parseFloat(f.css("top")) + "px" || "auto";
                        for (l = s.length - 1; 0 <= l; l--) h[s[l] + "transform"] = ""
                    }
                }
                f.unbind("webkitTransitionEnd oTransitionEnd transitionend");
                f.css(m.original).css(h).data("jQe", null)
            } else K.apply(f, [a, b])
        });
        return this
    }
})(jQuery, jQuery.fn.animate, jQuery.fn.stop); 