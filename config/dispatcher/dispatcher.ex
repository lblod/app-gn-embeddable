defmodule Dispatcher do
  use Matcher
  define_accept_types [
    json: [ "application/json", "application/vnd.api+json" ],
    html: [ "text/html", "application/xhtml+html" ],
    sparql: [ "application/sparql-results+json" ],
    any: [ "*/*" ]
  ]

  define_layers [ :static, :frontend, :api_services, :not_found ]

  options "/*_path", _ do
    conn
    |> Plug.Conn.put_resp_header( "access-control-allow-headers", "content-type,accept" )
    |> Plug.Conn.put_resp_header( "access-control-allow-methods", "*" )
    |> send_resp( 200, "{ \"message\": \"ok\" }" )
  end

  ###############
  # STATIC
  ###############
  match "", %{ layer: :static } do
    forward conn, [], "http://editor/test.html"
  end
  match "/", %{ layer: :static } do
    forward conn, [], "http://editor/test.html"
  end

  match "/index.html", %{ layer: :static } do
    forward conn, [], "http://editor/test.html"
  end

  match "/test.html", %{ layer: :static } do
    forward conn, [], "http://editor/test.html"
  end

  get "/assets/*path",  %{ layer: :static } do
    forward conn, path, "http://editor/assets/"
  end

  get "/@appuniversum/*path",  %{ layer: :static } do
    forward conn, path, "http://editor/@appuniversum/"
  end

  get "/favicon.ico", %{ layer: :static }  do
    send_resp( conn, 404, "" )
  end
  ###############
  # API SERVICES
  ###############


  match "/codex/sparql/*path", %{ layer: :api_services, accept: %{ sparql: true } } do
    forward conn, path, "http://codex-proxy/sparql/"
  end

  match "/concepts/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/concepts/"
  end

  match "/concept-schemes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/concept-schemes/"
  end

  match "/bestuurseenheden/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/bestuurseenheden/"
  end

  match "/bestuurseenheid-classificatie-codes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end

  match "/bestuursorganen/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/bestuursorganen/"
  end

  match "/bestuursorgaan-classificatie-codes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end

  match "/fracties/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://resource/fracties/"
  end

  match "/fractietypes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/fractietypes/"
  end

  match "/mandaten/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://resource/mandaten/"
  end

  match "/bestuursfunctie-codes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/bestuursfunctie-codes/"
  end

  match "/mandatarissen/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/mandatarissen/"
  end

  match "/mandataris-status-codes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/mandataris-status-codes/"
  end

  match "/personen/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/personen/"
  end

  match "/templates/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/templates/"
  end

  match "/rdfs-classes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/rdfs-classes/"
  end

  match "/rdfs-properties/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/rdfs-properties/"
  end

  match "/bestuursfuncties/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/bestuursfuncties/"
  end

  match "/functionarissen/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/functionarissen/"
  end

  match "/contact-punten/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/contact-punten/"
  end

  match "/adressen/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/adressen/"
  end

  match "/functionaris-status-codes/*path", %{ layer: :api_services, accept: %{ json: true } } do
    forward conn, path, "http://cache/functionaris-status-codes/"
  end

  #################
  # NOT FOUND
  #################

  match "/*_path", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
