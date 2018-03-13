layout: default.liquid
---

<div class="home">
  {% if site.data.header_text %}
  <div id="main" class="call-out"
  style="background-image: url('{{ site.base_url }}/{{ site.data.header_text_feature_image }}')">
    {{ site.data.header_text }}
  <a href="https://github.com/tmzt/isymtope" title=" GitHub" target="_blank">
        <span class="fa-stack fa-lg">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-github fa-stack-1x fa-inverse"></i>
        </span>
        Visit us on Github.
  </a>
  <a href="https://playground.isymtope.org" title=" Isymtope Playground">
        <span class="fa-stack fa-lg">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-paper-plane fa-stack-1x fa-inverse"></i>
        </span>
        Try it in the playground
  </a>
  </div>
  {% endif %}

  <div class="posts">
    <div class="post-teaser">
    {% include _sections/intro.md %}
    </div>
  </div>

  <div class="posts">
    {% for post in collections.posts.pages %}
    <div class="post-teaser">
      {% if post.thumbnail %} 
      <div class="post-img">
         <img src="{{ site.base_url }}/{{ post.thumbnail }}">
      </div>
      {% endif %}
      <span>
          <header>
            <h1>
              <a class="post-link" href="{{ post.permalink | prepend: site.base_url }}">
                {{ post.title }}
              </a>
            </h1>
            <p class="meta">
              {{ post.date | date: "%B %-d, %Y" }}
            </p>
          </header>
          <div class="excerpt">
            {{ post.excerpt }}
            <!--<a class="button" href="{{ post.url | prepend: site.base_url }}">
              {{ site.data.str_continue_reading }}
            </a>-->
          </div>
      </span>
    </div>
    {% endfor %}
  </div>

</div>
