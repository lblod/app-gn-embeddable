defmodule Dispatcher do
  use Matcher
  define_accept_types []

  match "/codex/sparql/*path" do
    forward conn, path, "http://codex-proxy/sparql/"
  end

  match "/concepts/*path" do
    forward conn, path, "http://cache/concepts/"
  end

  match "/concept-schemes/*path" do
    forward conn, path, "http://cache/concept-schemes/"
  end

  match "/bestuurseenheden/*path" do
    forward conn, path, "http://cache/bestuurseenheden/"
  end

  match "/bestuurseenheid-classificatie-codes/*path" do
    forward conn, path, "http://cache/bestuurseenheid-classificatie-codes/"
  end

  match "/bestuursorganen/*path" do
    forward conn, path, "http://cache/bestuursorganen/"
  end

  match "/bestuursorgaan-classificatie-codes/*path" do
    forward conn, path, "http://cache/bestuursorgaan-classificatie-codes/"
  end

  match "/fracties/*path" do
    forward conn, path, "http://resource/fracties/"
  end

  match "/fractietypes/*path" do
    forward conn, path, "http://cache/fractietypes/"
  end

  match "/mandaten/*path" do
    forward conn, path, "http://resource/mandaten/"
  end

  match "/bestuursfunctie-codes/*path" do
    forward conn, path, "http://cache/bestuursfunctie-codes/"
  end

  match "/mandatarissen/*path" do
    forward conn, path, "http://cache/mandatarissen/"
  end

  match "/mandataris-status-codes/*path" do
    forward conn, path, "http://cache/mandataris-status-codes/"
  end

  match "/personen/*path" do
    forward conn, path, "http://cache/personen/"
  end

  match "/templates/*path" do
    forward conn, path, "http://cache/templates/"
  end

  match "/rdfs-classes/*path" do
    forward conn, path, "http://cache/rdfs-classes/"
  end

  match "/rdfs-properties/*path" do
    forward conn, path, "http://cache/rdfs-properties/"
  end

  match "/bestuursfuncties/*path" do
    forward conn, path, "http://cache/bestuursfuncties/"
  end

  match "/functionarissen/*path" do
    forward conn, path, "http://cache/functionarissen/"
  end

  match "/contact-punten/*path" do
    forward conn, path, "http://cache/contact-punten/"
  end

  match "/adressen/*path" do
    forward conn, path, "http://cache/adressen/"
  end

  match "/functionaris-status-codes/*path" do
    forward conn, path, "http://cache/functionaris-status-codes/"
  end

  match "_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end
end
