(function (n) {
  n(["jquery"], function (n) {
    function et(n) {
      t.modal(g).find(".modal-content").append(n)
    }

    function f() {
      var i, r;
      try {
        r = require("Q")
      } catch (u) {
        r = window.Q
      }
      return r ? i = r.defer() : (i = n.Deferred(), i.promise = i.promise()), i.promise.element = t, i
    }

    function it(t) {
      var e, o, s, i, f, u, c;
      if (t === !1)return r;
      if (e = n(h).addClass("modal-footer").prop("id", ft), t)for (o = 0, s = t.length; o < s; o++) {
        i = t[o];
        f = n("<button>").addClass("btn btn-" + (i.style || "primary"));
        for (u in i)if (i.hasOwnProperty(u))switch (u) {
          case"close":
            i[u] && f.attr("data-dismiss", "modal").addClass("x");
            break;
          case w:
            c = i.click.bind(rt(!0).find(".modal-content"));
            f.click(c);
            break;
          case"text":
            f.html(i[u]);
            break;
          default:
            f.attr(u, i[u])
        }
        e.append(f)
      } else e.append('<button class="x btn btn-primary" data-dismiss=modal type=button>Close<\/button>');
      return e
    }

    function ot(t) {
      var r, u = t.loading ? i.loadingHtml : t.message || t;
      return u.on || u.onclick ? (r = t.clone === !0 ? n(u).clone() : n(u), r.addClass(t.useBin && !t.loading ? p : tt)) : r = n(h).attr("style", "position:relative;word-wrap:break-word;").addClass(y).html(u), t.css && t.css !== r.css && r.css(t.css), r
    }

    function rt(i) {
      function r() {
        return n('<div class="modal fade" tabindex="-1"><style>.modal-xl{width:96%;}<\/style><div class=modal-dialog><div class=modal-content> <div class=modal-header><button type=button class="x close" data-dismiss=modal><span aria-hidden=true>&times;<\/span><span class=sr-only>Close<\/span><\/button><h4 class=modal-title><\/h4><\/div><\/div><\/div><\/div>').on("hidden.bs.modal", ut).on(w, "button.x", function (i) {
          var r = n(i.currentTarget);
          if (r.prop("type") !== c)return t.modal(l);
          try {
            if (r.closest("form")[0].checkValidity())return o()
          } catch (u) {
            return o()
          }
          return t
        })
      }

      return (t || (document.getElementById(s) || n("body").append(n(h).prop("id", s).hide()), t = r()), i && t) ? t : t.on(a, function () {
        n(this).find(b).first().focus()
      })
    }

    function ut() {
      if (t) {
        var n = t.find("." + p).removeClass(p).appendTo("#" + s);
        t.off(v).off(a).find(".modal-content > div:not(:first-child)").remove();
        (!i.allowContentRecycle || d.clone) && n.remove()
      }
    }

    function st(t, u) {
      if (!t)throw new Error("Invalid parameters!");
      ut();
      d = t;
      var f = rt();
      f.find(".modal-dialog").removeClass("modal-sm modal-lg modal-xl").addClass(t.size ? "modal-" + t.size : i.size);
      f.find(".modal-title").html((t.title || u || i.title) + " ").append(n("<small>").html(t.subtitle || r));
      f.on(v, t.onHide)
    }

    function ht(r, u) {
      function h(n) {
        return t.find("." + y).html(n), s.resolve(t)
      }

      function c(n) {
        var i = '<div class="alert alert-danger"><strong>XHR Fail: <\/strong>URL [ ' + o.url + "] load fail.<\/div>";
        return t.find("." + y).html(i), s.reject(n)
      }

      var s = f(), o = {async: !0, deferred: s, loading: !0, title: r.title || u || i.title, url: r.url || r};
      return r.url && n.extend(o, r), n.ajax({url: o.url, dataType: "text"}).success(h).fail(c), e(o, u)
    }

    function e(i, r) {
      st(i, r);
      var u = i.deferred || f(), e = n(h).append(ot(i), it(i.buttons));
      if (et(e), !i.async)t.on(a, u.resolve);
      return u.promise
    }

    function ct(t, r) {
      function h(t) {
        o();
        var i = n(t.currentTarget).html();
        return u[i] ? s.resolve() : s.reject()
      }

      var s = f();
      return e({
        async: !0,
        buttons: [{close: !0, click: h, text: u[t.label] ? u[t.label] : u[i.confirmLabel], style: k}, {
          close: !0,
          click: h,
          text: u[t.label] ? t.label : i.confirmLabel
        }],
        deferred: s,
        message: t.message || t,
        onHide: h,
        size: t.size,
        title: t.title || r
      })
    }

    function lt(t, r) {
      function h() {
        return n(this).parent().find("div." + tt).fadeOut(function () {
          n(this).remove()
        }), u.resolve()
      }

      var u = f(), o = '<div class=modal-body style="position: absolute;width: 100%;background-color: rgba(255,255,255,0.8);height: 100%;">%1%<\/div><iframe class="embed-responsive-item" frameborder=0 src="%0%" style="width:100%;height:75vh;display:block;"/>'.replace("%0%", t.message || t.url || t).replace("%1%", i.loadingHtml), s = n(o).load(h);
      return e({
        async: !0,
        buttons: t.buttons || !1,
        deferred: u,
        message: s,
        size: t.size || nt.xl,
        title: t.title || r
      })
    }

    function at() {
      return n("#" + s + " > *").remove()
    }

    function vt(s, h) {
      function d(n) {
        var i = t.find(b).val();
        return o(), n.type !== c ? y.reject(i) : y.resolve(i), !1
      }

      var y = f(), l = {deferred: y}, a, v, p, w;
      if (typeof s == "object" ? n.extend(l, s) : (l.message = s, l.title = h), l.async = !0, l.buttons)for (v = 0, p = l.buttons.length; v < p; v++)a = l.buttons[v], a.style = (a.style || "default") + " pull-left", a.type = a.type || "button";
      return w = it([{close: !0, type: "reset", text: u.OK, style: k}, {
        close: !1,
        type: c,
        text: i.confirmLabel
      }].concat(l.buttons || [])), l.buttons = !1, l.onHide = d, l.message = n('<form role=form style="margin-bottom:0;"><div class=modal-body><label for=prompt-input class=control-label>' + (l.message || r) + '<\/label><input type=text class=form-control required autocomplete="on" value="' + (l.value || r) + (l.pattern ? '" pattern="' + l.pattern : r) + '"><\/div><\/form>').append(w).on(c, d), e(l)
    }

    function yt(t) {
      return n.extend(i, t)
    }

    function pt(i) {
      return t && t.remove(), n.extend(g, i)
    }

    function o() {
      return t && t.off(v).modal(l), t
    }

    var t, s = "recycle-bin", h = "<div>", r = "", w = "click", l = "hide", a = "shown.bs.modal", c = "submit", ft = "eFooter", v = l + ".bs.modal", b = "input", k = "danger", u = {
      OK: "Cancel",
      True: "False",
      Yes: "No"
    }, d = {}, y = "modal-body", g = {}, p = "modal-rec", nt = {
      sm: "sm",
      lg: "lg",
      xl: "xl"
    }, tt = "modal-tmp", i = {
      allowContentRecycle: !0,
      confirmLabel: "OK",
      size: r,
      loadingHtml: '<h5>Loading...<\/h5><div class=progress><div class="progress-bar progress-bar-striped active" style="width: 100%"><\/div><\/div>',
      title: "Attention"
    };
    return {
      ajax: ht,
      alert: e,
      close: o,
      confirm: ct,
      emptyBin: at,
      iframe: lt,
      prompt: vt,
      setEModalOptions: yt,
      setModalOptions: pt,
      size: nt,
      version: "1.2.04"
    }
  })
})(typeof define == "function" && define.amd ? define : function (n, t) {
  typeof module != "undefined" && window.module.exports ? window.module.exports = t(window.require(n[0])) : window.eModal = t(window.$)
});
//# sourceMappingURL=eModal.min.js.map
