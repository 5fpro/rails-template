class SlackNotifier < Tyr::SlackNotifier

  class << self
    private

    def default_channel
      '#notify-debug'
    end
  end
end
