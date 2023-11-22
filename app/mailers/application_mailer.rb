class ApplicationMailer < Tyr::ApplicationMailer
  def manual_send(to:, **options)
    mail(to:, **options)
  end
end
