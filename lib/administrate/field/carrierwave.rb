# frozen_string_literal: true

require 'administrate/field/base'
require 'rails'

module Administrate
  module Field
    class Carrierwave < Administrate::Field::Base
      class Engine < ::Rails::Engine; end

      def image
        options.fetch(:image, nil)
      end

      def image_on_index?
        options.fetch(:image_on_index, false)
      end

      def multiple?
        options.fetch(:multiple, false)
      end

      def remove?
        options.fetch(:remove, false)
      end

      def remote_url?
        options.fetch(:remote_url, false)
      end

      def files
        Array[*data]
      end

      def file
        files.first
      end

      def model
        data.try(:model)
      end

      def show_preview?
        has_file = model.try(:persisted?) && file.present?
        has_file && (image ? file.version_exists?(image) : true)
      end

      def show_file?
        file.present?
      end
    end
  end
end
