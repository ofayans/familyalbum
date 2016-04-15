"""empty message

Revision ID: ccaeddbd4688
Revises: ef86598b14db
Create Date: 2016-04-12 09:11:46.123969

"""

# revision identifiers, used by Alembic.
revision = 'ccaeddbd4688'
down_revision = 'ef86598b14db'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.create_table('possiblerelative',
    sa.Column('id', sa.Unicode(), nullable=False),
    sa.Column('person_id', sa.Unicode(), nullable=False),
    sa.Column('target_id', sa.Unicode(), nullable=False),
    sa.Column('relation', sa.Unicode(), nullable=True),
    sa.ForeignKeyConstraint(['person_id'], ['person.id'], ),
    sa.ForeignKeyConstraint(['target_id'], ['person.id'], ),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_possiblerelative_id'), 'possiblerelative', ['id'], unique=False)
    op.create_foreign_key(None, 'family_possible_members', 'possiblerelative', ['possible_member_id'], ['id'])
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'family_possible_members', type_='foreignkey')
    op.drop_index(op.f('ix_possiblerelative_id'), table_name='possiblerelative')
    op.drop_table('possiblerelative')
    ### end Alembic commands ###