# frozen_string_literal: true

class NotesController < ApplicationController
  def index
    @notes = Note.order(created_at: :desc)
  end

  def show
    # debugger
    @note = Note.find(params[:id])
  end
end
